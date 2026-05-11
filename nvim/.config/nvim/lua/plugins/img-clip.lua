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

local function make_markdown_image_template(context)
  local piclist_endpoint = "http://127.0.0.1:36677/upload"

  -- 如果 PicList 开启了接口鉴权，改成：
  -- local piclist_endpoint = "http://127.0.0.1:36677/upload?key=你的key"

  local body = vim.fn.json_encode({
    list = { context.file_path },
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
    vim.notify("PicList 上传失败：\n" .. result, vim.log.levels.ERROR)
    return "![" .. context.cursor .. "](" .. context.file_path .. ")"
  end

  local ok, decoded = pcall(vim.fn.json_decode, result)
  if not ok or not decoded then
    vim.notify("PicList 返回内容无法解析：\n" .. result, vim.log.levels.ERROR)
    return "![" .. context.cursor .. "](" .. context.file_path .. ")"
  end

  if decoded.success and decoded.result and decoded.result[1] then
    local url = decoded.result[1]

    -- 上传成功后删除本地临时图片
    pcall(vim.fn.delete, context.file_path)

    return "![" .. context.cursor .. "](" .. url .. ")"
  end

  vim.notify("PicList 上传未成功：\n" .. result, vim.log.levels.ERROR)
  return "![" .. context.cursor .. "](" .. context.file_path .. ")"
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
    keys = {
      {
        "<leader>ip",
        "<cmd>PasteImage<cr>",
        desc = "Paste image and upload via PicList",
      },
    },
  },
}
