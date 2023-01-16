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
--
-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │ 快捷键映射                                                                   │
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
function loadModule(require_path, scope)
  local status_ok, module = pcall(require, require_path);
  if status_ok then
    return module;
  else
    vim.notify(string.format("[%s]%s not found", scope, require_path));
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
