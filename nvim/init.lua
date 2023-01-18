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
-- TODO: 3. 寻找一个更好的处理...
-- TODO: 4. 安装neodev，将vim lua api的signatures加入到lsp中
-- TODO: 5. 使用alpha-nvim替换dashboard
-- TODO: 7. 更好的处理缩进的方法（比如回车后让括号、光标的位置更加适合我的习惯）
-- TODO: 8. plugin lazy loading
-- TODO: 10. 取消inactivate buffer的buffer显示（barbar)
-- TODO: 11. null-ls的安装和配置
-- TODO: 12. 设置一个按键，可以手动开启补全
-- TODO: 13. 现在无法同时创建多个terminal
-- TODO: 14. 安装copilot玩一玩
-- TODO: 20. nvimTree设置root dir
-- TODO: 21. gitsigns的配置
-- TODO: 22. statusline中加入开启的LSP server的信息
-- TODO: 23. 多个windows开启时，使用nvim-tree打开文件需要进行窗口选择，这时候会出现字符错误
