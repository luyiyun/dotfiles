-----------------------------------------------------------------------
--                                                                   --
--                           全局工具函数                            --
--                         global functions                          --
--                                                                   --
-----------------------------------------------------------------------
---@diagnostic disable: lowercase-global
-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │ 加载vimscript 全局工具函数                                                   │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
-- vim.cmd [[runtime ./scripts/functions.vim]];
--
root_patterns = { ".git", "lua" }
--
-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │ 得到当前的系统类型                                                           │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
function osinfo()
  local os = vim.bo.fileformat:upper()
  if os ~= "UNIX" and os ~= "MAC" then
    return "WIN"
  else
    return os
  end
end

-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │ 快捷键映射                                                                   │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
local keymap = vim.api.nvim_set_keymap
local option = { noremap = true, silent = true };
function nnoremap(keys, commands)
  keymap("n", keys, commands, option);
end

function vnoremap(keys, commands)
  keymap("v", keys, commands, option);
end

function inoremap(keys, commands)
  keymap("i", keys, commands, option);
end

function xnoremap(keys, commands)
  keymap("x", keys, commands, option);
end

function cmap(keys, commands)
  keymap("c", keys, commands, { silent = true });
end

-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │  安全的加载模块                                                              │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
local notify_ok, notify = pcall(require, "notify");
if notify_ok then
  vim.notify = notify
end
function loadModule(require_path, scope)
  local status_ok, module = pcall(require, require_path);
  if status_ok then
    return module;
  else
    vim.notify(string.format("[%s]%s not found", scope, require_path), "error");
    return {};
  end
end

-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │ 获取选中的内容                                                               │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
function getVisualSelection()
  vim.cmd('noautocmd normal! "vy"');
  ---@diagnostic disable-next-line: missing-parameter
  local text = vim.fn.getreg('v');
  vim.fn.setreg('v', {});

  text = string.gsub(text, "\n", "");
  if #text > 0 then
    return text;
  else
    return "";
  end
end

-- 将table转换为字符串, 方便输出调试
---@diagnostic disable-next-line
-- function tab2str(o)
--   if type(o) == 'table' then
--     local s = '{ '
--     for k, v in pairs(o) do
--       if type(k) ~= 'number' then k = '"' .. k .. '"' end
--       s = s .. '[' .. k .. '] = ' .. tab2str(v) .. ','
--     end
--   else
--     return tostring(o)
--   end
-- end

-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │ 找到当前的root                                                              │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
-- returns the root directory based on:
-- * lsp workspace folders
-- * lsp root_dir
-- * root pattern of filename of the current buffer
-- * root pattern of cwd
---@return string
function get_root()
  ---@type string?
  local path = vim.api.nvim_buf_get_name(0)
  path = path ~= "" and vim.loop.fs_realpath(path) or nil
  ---@type string[]
  local roots = {}
  if path then
    for _, client in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
      local workspace = client.config.workspace_folders
      local paths = workspace and vim.tbl_map(function(ws)
        return vim.uri_to_fname(ws.uri)
      end, workspace) or client.config.root_dir and { client.config.root_dir } or {}
      for _, p in ipairs(paths) do
        local r = vim.loop.fs_realpath(p)
        if path:find(r, 1, true) then
          roots[#roots + 1] = r
        end
      end
    end
  end
  table.sort(roots, function(a, b)
    return #a > #b
  end)
  ---@type string?
  local root = roots[1]
  if not root then
    path = path and vim.fs.dirname(path) or vim.loop.cwd()
    ---@type string?
    root = vim.fs.find(root_patterns, { path = path, upward = true })[1]
    root = root and vim.fs.dirname(root) or vim.loop.cwd()
  end
  ---@cast root string
  return root
end

-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │ set the font size                                                            │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
function setFontSize(font_family, font_size)
  font_family = font_family or "FiraCode Nerd Font Mono"
  font_size = font_size or 10
  vim.opt.guifont = string.format("%s:h%s", font_family, font_size or 10)
end
