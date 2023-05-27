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
require("plugins_lazy")
-- require("plugins_packer")
require("lsp-configs")

-- vim.cmd [[silent! colorscheme onedark]]
-- vim.g.material_style = "lighter"
-- vim.cmd [[silent! colorscheme material]]
-- vim.cmd [[silent! colorscheme catppuccin-latte]]
vim.cmd.colorscheme("base16-gruvbox-dark-soft")

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

-- TODO: 将main中的配置分离成单个文件，并将plugin config中的内容加入其中，并参考
-- TODO:  LazyVim的配置，将懒加载机制充分利用

-- TODO: 0. 取消光标移动到括号时的高亮
-- TODO: 0. 使用lazy.nvim的懒加载机制，慢慢提高neovim的启动速度
-- TODO: 0. 对noice.nvim进行配置，探索其更多的功能（比如statusline中的组件）
-- TODO: 0. noice.nvim，通知显示的时间太长，可能会遮挡住文件，可能难以进行编辑
-- TODO: 1. lspsaga的配置还存在一些问题，比如查看文档等不太方便
-- TODO: 2. 找一个新的多行操作插件
-- TODO: 4. 安装neodev，将vim lua api的signatures加入到lsp中
-- TODO: 5. 使用alpha-nvim替换dashboard
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
