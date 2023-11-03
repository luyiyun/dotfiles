-- 安装前置工具
-- 1. neovim 0.8+
-- 2. node和npm，设置好国内镜像
-- 3. 安装make，gcc, (windows可以通过scoop进行安装（scoop的安装查看https://zhuanlan.zhihu.com/p/594363658）)
-- 4. 安装ripgrep
-- 5. 安装fd，(optional 更快的file browser)   TODO:
--

require("functions") -- custom utility functions
require("options") -- basic settings (like line number, tab size, ...)
require("mappings") -- basic keyboard mappings (like leader, switching windows, ...)
require("plugins_lazy") -- plugins managed by lazy.nvim

-- vim.cmd([[silent! colorscheme onedark]])
-- vim.cmd([[silent! colorscheme tokyonight-day]])
vim.g.material_style = "lighter"
vim.cmd [[silent! colorscheme material]]
-- vim.cmd [[silent! colorscheme catppuccin-latte]]
-- vim.cmd [[silent! colorscheme catppuccin-frappe]]
-- vim.cmd.colorscheme("base16-gruvbox-dark-soft")

-- neovide
vim.g.isNeovide = false;
if vim.fn.exists("g:neovide") == 1 then
  vim.g.isNeovide = true;
  require("neovide")
end

-- 配置颜色方案
-- vim.api.nvim_set_hl(0, "BufferVisibleERROR", {bg = "#282c34", fg = "#e86671"})
-- vim.api.nvim_set_hl(0, "BufferVisibleINFO", {bg = "#282c34", fg = "#ffb7b7"})
-- vim.api.nvim_set_hl(0, "BufferVisibleHINT", {bg = "#282c34", fg = "#d5508f"})
--
--
--
-- TODO: 切换branch时自动刷新buffer
-- TODO: 每次从nvim使用session manager转换到python相关的工作环境时会报错
-- TODO: 加入一个merge conflict的插件
-- TODO: 0. 取消光标移动到括号时的高亮
-- TODO: 0. 对noice.nvim进行配置，探索其更多的功能（比如statusline中的组件）
-- TODO: 0. noice.nvim，通知显示的时间太长，可能会遮挡住文件，可能难以进行编辑
-- TODO: 1. lspsaga的配置还存在一些问题，比如查看文档等不太方便
-- TODO: 2. 找一个新的多行操作插件
-- TODO: 10. 取消inactivate buffer的buffer显示（barbar)
-- TODO: 13. 现在无法同时创建多个terminal
-- TODO: 14. 安装copilot玩一玩
-- TODO: 21. gitsigns的配置


-- 问题解决：
-- lua_ls 存在一个问题，其会在每次一开始询问是否配置luv，并且无法关掉。
--     除了要对lua_ls的参数进行设置,还要删除掉.luarc.json文件，令其重新生成。
-- guard.nvim的安装和配置
--     现在使用null-ls
-- nvimTree设置root dir
--     现在使用neotree，其有快捷键来设置root_dir，同时我们也仿照LazyVim写了一个自动化获取root dir的函数
-- statusline中加入开启的LSP server的信息
--     已解决，见bottom_bar.lua
-- symbols-outline会报错
--     使用telescope自带的lsp_document_symbols (<leader>fu)
--     use navbuddy and barbucue
