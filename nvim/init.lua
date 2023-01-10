-- 安装前置工具
-- 1. neovim 0.8+
-- 2. node和npm，设置好国内镜像
-- 3. 安装ripgrep、make (windows可以通过scoop进行安装（scoop的安装查看https://zhuanlan.zhihu.com/p/594363658）)
-- 4. 安装fd，(optional 更快的file browser)   TODO: 
--


require("functions")
require("options")
require("mappings")
require("plugins")
require("lsp-configs")

-- neovide
vim.g.isNeovide = false;
if vim.fn.exists("g:neovide") == 1 then
  vim.g.isNeovide = true;
  require("neovide")
end


--
-- TODO: 1. lspsaga还是默认lspconfig（当前没有开启lspsaga）。
-- TODO: 2. vim-visual-multi的配置
-- TODO: 5. visual过程的缩进，会在缩进一次后就退出visual模式，这很不方便
-- TODO: 6. 设置快捷键(telescope-file-browser)
-- TODO: 9. 让分屏的也有statusline(feline), 现在是通过设置所有的window都共用一个来解决的
-- TODO: 10. 更改buffer栏的错误图标(barbar)
-- TODO: 13. 现在无法同时创建多个terminal
-- TODO: 14. 安装copilot玩一玩
-- TODO: 15. 保存的session给个名字
-- TODO: 16. cmdline中，使用esc会运行当前命令，能不能取消掉
-- TODO: 17. session和nvim-tree结合不好
-- TODO: 18. session的重命名
-- TODO: 19. telescope session和telescope filebrowser上的快捷键配置
-- TODO: 20. nvimTree设置root dir
