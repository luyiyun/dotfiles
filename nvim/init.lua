-- 安装前置工具
-- 1. neovim 0.8+
-- 2. node和npm，设置好国内镜像
-- 3. 安装make，gcc, (windows可以通过scoop进行安装（scoop的安装查看https://zhuanlan.zhihu.com/p/594363658）)
-- 4. 安装ripgrep 
-- 5. 安装fd，(optional 更快的file browser)   TODO: 
--


require("functions")
require("options")
require("mappings")
require("plugins")
require("lsp-configs")

-- neovide
-- vim.g.isNeovide = false;
-- if vim.fn.exists("g:neovide") == 1 then
--   vim.g.isNeovide = true;
--   require("neovide")
-- end

-- 配置颜色方案
vim.api.nvim_set_hl(0, "BufferVisibleERROR", {bg = "#282c34", fg = "#e86671"})
vim.api.nvim_set_hl(0, "BufferVisibleINFO", {bg = "#282c34", fg = "#ffb7b7"})
vim.api.nvim_set_hl(0, "BufferVisibleHINT", {bg = "#282c34", fg = "#d5508f"})

--
-- TODO: 1. lspsaga的配置还存在一些问题，比如查看文档等不太方便
-- TODO: 2. 找一个新的多行操作插件
-- TODO: 3. 使用notify插件
-- TODO: 5. visual过程的缩进，会在缩进一次后就退出visual模式，这很不方便
-- TODO: 9. 让分屏的也有statusline(feline), 并且使其展示文件名和路径
-- TODO: 10. 取消inactivate buffer的buffer显示（barbar)
-- TODO: 10. 更改buffer栏的错误图标(barbar)，部分解决，利用上面显式来确定颜色方案
-- TODO: 13. 现在无法同时创建多个terminal
-- TODO: 14. 安装copilot玩一玩
-- TODO: 20. nvimTree设置root dir
-- TODO: 21. gitsigns的配置
