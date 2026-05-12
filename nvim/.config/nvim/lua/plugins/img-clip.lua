local function normalize_image_name(input)
  input = vim.trim(input or "")

  -- 用户直接回车时使用默认名称
  if input == "" then
    input = "image"
  end

  -- 去掉用户可能手动输入的扩展名：xxx.png / xxx.jpg / xxx.jpeg / xxx.webp
  input = input:gsub("%.[Pp][Nn][Gg]$", "")
  input = input:gsub("%.[Jj][Pp][Gg]$", "")
  input = input:gsub("%.[Jj][Pp][Ee][Gg]$", "")
  input = input:gsub("%.[Ww][Ee][Bb][Pp]$", "")

  -- 替换路径分隔符，避免把文件名误解析为目录
  input = input:gsub("[/\\]", "-")

  -- 替换常见文件名危险字符；中文会被保留
  input = input:gsub('[:*?"<>|]', "-")

  -- 空格统一替换为 -
  input = input:gsub("%s+", "-")

  -- 避免连续多个 -
  input = input:gsub("%-+", "-")
  input = input:gsub("^%-", "")
  input = input:gsub("%-$", "")

  if input == "" then
    input = "image"
  end

  return input
end

local function prompt_image_file_name()
  local raw = vim.fn.input({
    prompt = "Image name: ",
    default = "",
  })

  local name = normalize_image_name(raw)
  local timestamp = os.date("%Y%m%d-%H%M%S")

  -- 注意：这里不要加 .png，扩展名由 img-clip 的 extension 决定
  return name .. "-" .. timestamp
end

local piclist_endpoint = "http://127.0.0.1:36677/upload"

-- 如果 PicList 开启了接口鉴权，改成：
-- local piclist_endpoint = "http://127.0.0.1:36677/upload?key=你的key"

local function upload_to_piclist(file_path)
  local body = vim.fn.json_encode({
    list = { file_path },
  })

  local result = vim.fn.system({
    "curl",
    "-sS",
    "-X",
    "POST",
    "-H",
    "Content-Type: application/json",
    "-d",
    body,
    piclist_endpoint,
  })

  if vim.v.shell_error ~= 0 then
    return nil, "PicList 上传失败：\n" .. result
  end

  local ok, decoded = pcall(vim.fn.json_decode, result)
  if not ok or not decoded then
    return nil, "PicList 返回内容无法解析：\n" .. result
  end

  if decoded.success and decoded.result and decoded.result[1] then
    return decoded.result[1], nil
  end

  return nil, "PicList 上传未成功：\n" .. result
end

local function make_markdown_image_template(context)
  local url, err = upload_to_piclist(context.file_path)

  if not url then
    vim.notify(err, vim.log.levels.ERROR)
    return "![" .. context.cursor .. "](" .. context.file_path .. ")"
  end

  -- 上传成功后删除 img-clip 保存到缓存目录的临时图片
  pcall(vim.fn.delete, context.file_path)

  return "![" .. context.cursor .. "](" .. url .. ")"
end

local function is_remote_image_path(path)
  return path:match("^https?://") or path:match("^data:")
end

local function is_absolute_path(path)
  return path:sub(1, 1) == "/" or path:match("^%a:[/\\]")
end

local function split_markdown_link_target(target)
  target = vim.trim(target or "")

  if target:sub(1, 1) == "<" then
    local path, suffix = target:match("^<([^>]+)>(.*)$")
    return path or target, suffix or ""
  end

  local path, suffix = target:match("^(%S+)(%s+.+)$")
  return path or target, suffix or ""
end

local function decode_path(path)
  if vim.uri_to_fname and path:match("^file://") then
    local ok, file_path = pcall(vim.uri_to_fname, path)
    if ok then
      return file_path
    end
  end

  if vim.uri_decode then
    local ok, decoded = pcall(vim.uri_decode, path)
    if ok then
      return decoded
    end
  end

  return path
end

local function resolve_local_image_path(raw_path)
  local path = decode_path(raw_path)

  if is_remote_image_path(path) then
    return nil, "当前图片已经是远程链接"
  end

  if path:sub(1, 1) == "~" then
    path = vim.fn.expand(path)
  elseif not is_absolute_path(path) then
    local buffer_name = vim.api.nvim_buf_get_name(0)
    local base_dir = buffer_name ~= "" and vim.fn.fnamemodify(buffer_name, ":p:h") or vim.fn.getcwd()
    path = base_dir .. "/" .. path
  end

  path = vim.fn.fnamemodify(path, ":p")

  if vim.fn.filereadable(path) ~= 1 then
    return nil, "找不到本地图片文件：" .. path
  end

  return path, nil
end

local function find_markdown_image_on_line(line)
  local cursor_col = vim.fn.col(".")
  local search_start = 1
  local fallback = nil

  while true do
    local start_col, finish_col, alt, target = line:find("!%[([^%]]*)%]%(([^%)]+)%)", search_start)

    if not start_col then
      break
    end

    local match = {
      start_col = start_col,
      finish_col = finish_col,
      alt = alt,
      target = target,
    }

    fallback = fallback or match

    if cursor_col >= start_col and cursor_col <= finish_col then
      return match
    end

    search_start = finish_col + 1
  end

  return fallback
end

local function upload_current_line_local_image()
  local line = vim.api.nvim_get_current_line()
  local image = find_markdown_image_on_line(line)

  if not image then
    vim.notify("当前行没有找到 Markdown 图片链接", vim.log.levels.WARN)
    return
  end

  local raw_path, suffix = split_markdown_link_target(image.target)
  local file_path, err = resolve_local_image_path(raw_path)

  if not file_path then
    vim.notify(err, vim.log.levels.WARN)
    return
  end

  local url, upload_err = upload_to_piclist(file_path)

  if not url then
    vim.notify(upload_err, vim.log.levels.ERROR)
    return
  end

  local replacement = "![" .. image.alt .. "](" .. url .. suffix .. ")"
  local new_line = line:sub(1, image.start_col - 1) .. replacement .. line:sub(image.finish_col + 1)
  vim.api.nvim_set_current_line(new_line)
  vim.notify("已上传并替换本地图片链接", vim.log.levels.INFO)
end

return {
  {
    "HakonHarnes/img-clip.nvim",
    ft = { "markdown", "quarto" },
    opts = {
      default = {
        dir_path = vim.fn.stdpath("cache") .. "/img-clip",

        -- 每次 PasteImage 时都会调用这个函数
        file_name = prompt_image_file_name,

        extension = "png",
        use_absolute_path = true,
        relative_to_current_file = false,

        -- 这里必须关掉，否则 img-clip 自己还会再问一次文件名
        prompt_for_file_name = false,

        embed_image_as_base64 = false,
        copy_images = false,
        download_images = false,
      },

      filetypes = {
        markdown = {
          template = make_markdown_image_template,
          url_encode_path = false,
        },
        quarto = {
          template = make_markdown_image_template,
          url_encode_path = false,
        },
      },
    },
    init = function()
      vim.api.nvim_create_user_command("UploadLocalImage", upload_current_line_local_image, {
        desc = "Upload current-line local Markdown image via PicList",
      })
    end,
    keys = {
      {
        "<leader>ip",
        "<cmd>PasteImage<cr>",
        desc = "Paste image and upload via PicList",
      },
      {
        "<leader>iu",
        upload_current_line_local_image,
        desc = "Upload local image via PicList",
      },
    },
  },
}
