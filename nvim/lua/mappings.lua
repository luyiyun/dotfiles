--  .----------------.  .----------------.  .----------------.  .----------------.  .----------------.  .-----------------. .----------------.  .----------------.
-- | .--------------. || .--------------. || .--------------. || .--------------. || .--------------. || .--------------. || .--------------. || .--------------. |
-- | | ____    ____ | || |      __      | || |   ______     | || |   ______     | || |     _____    | || | ____  _____  | || |    ______    | || |    _______   | |
-- | ||_   \  /   _|| || |     /  \     | || |  |_   __ \   | || |  |_   __ \   | || |    |_   _|   | || ||_   \|_   _| | || |  .' ___  |   | || |   /  ___  |  | |
-- | |  |   \/   |  | || |    / /\ \    | || |    | |__) |  | || |    | |__) |  | || |      | |     | || |  |   \ | |   | || | / .'   \_|   | || |  |  (__ \_|  | |
-- | |  | |\  /| |  | || |   / ____ \   | || |    |  ___/   | || |    |  ___/   | || |      | |     | || |  | |\ \| |   | || | | |    ____  | || |   '.___`-.   | |
-- | | _| |_\/_| |_ | || | _/ /    \ \_ | || |   _| |_      | || |   _| |_      | || |     _| |_    | || | _| |_\   |_  | || | \ `.___]  _| | || |  |`\____) |  | |
-- | ||_____||_____|| || ||____|  |____|| || |  |_____|     | || |  |_____|     | || |    |_____|   | || ||_____|\____| | || |  `._____.'   | || |  |_______.'  | |
-- | |              | || |              | || |              | || |              | || |              | || |              | || |              | || |              | |
-- | '--------------' || '--------------' || '--------------' || '--------------' || '--------------' || '--------------' || '--------------' || '--------------' |
--  '----------------'  '----------------'  '----------------'  '----------------'  '----------------'  '----------------'  '----------------'  '----------------'
--  传统快捷键映射，这里只定义了少量的常用快捷键，大量的其他快捷键是使用
--      which key定义的，定义在keybindings中
-- 在这里定义快捷键映射:
-- mapclear - 取消所有自定义快捷键映射
-- nmap     - 查看 normal 模式快捷键
-- imap     - 查看 inrert 模式快捷键
-- vmap     - 查看 virual 模式快捷键
-- xmap     - 查看 virual block 模式快捷键
-- cmap     - 查看 command-line 模式快捷键
-- rmap     - 查看 select 模式快捷键
-- omap     - 查看 operator 模式快捷键
-- 将空格键设置为 <leader> 键
vim.api.nvim_set_keymap("", " ", "<Nop>", {
  noremap = true,
  silent = true
})
vim.g.mapleader = " "
vim.g.localleader = " "

-- 取消高亮
nnoremap("-", "<cmd>nohl<CR>")

-- 将esc在cmdline的行为覆盖掉
vim.api.nvim_set_keymap("c", "<esc>", "<C-c>", {noremap = true, silent = true})
-- NOTE: cmdline中，使用esc会运行当前命令，这无法关闭，可以使用<C-c>来代替，详情见：
--  https://github.com/neovim/neovim/issues/21585
--  https://groups.google.com/g/vim_use/c/8Mhs9spyzCM/m/qEFr6AFshWcJ
--  实际上在vim中，cpoptions设置中如果存在x字符，则esc会执行命令；如果没有x字符则不执行。
--  neovim的cpoptions默认并没有x字符，但neovim为了实现一个功能，让其绕过了cpoptions，
--  所以cpoptions的设置并没有奏效。

-- 分屏时上下左右移动
nnoremap("<C-j>", "<C-w>j")
nnoremap("<C-h>", "<C-w>h")
nnoremap("<C-k>", "<C-w>k")
nnoremap("<C-l>", "<C-w>l")

-- 在分屏时调整当前窗口大小
nnoremap("<C-Right>", "<cmd>vertical resize-1<CR>")
nnoremap("<C-Left>", "<cmd>vertical resize+1<CR>")
nnoremap("<C-Down>", "<cmd>resize-1<CR>")
nnoremap("<C-Up>", "<cmd>resize+1 <CR>")

-- 命令行左右移动/上下选中
cmap("<C-j>", "<C-n>")
cmap("<C-k>", "<C-p>")

-- save and quit
vim.keymap.set({"n", "v"}, "<C-s>", "<cmd>:w<CR>", {noremap = true, silent = true})
vim.keymap.set({"n", "v"}, "<C-q>", "<cmd>:q<CR>", {noremap = true, silent = true})

-- 左右缩进，这样移动后不会退出visual mode
vnoremap("<", "<gv")
vnoremap(">", ">gv")


-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │                                 日常编辑使用                                 │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
-- local wk = loadModule("which-key", "keybindings");
-- wk.register({
--     w = {
--         name = "+Windows",
--         s = {"<cmd>split<CR>", "horizontally split"},
--         v = {"<cmd>vsplit<CR>", "vertically split"},
--         o = {"<cmd>only<CR>", "remove all windows except current one"},
--         h = {"<c-w>H", "move current window on left"},
--         j = {"<c-w>J", "move current window on bottom"},
--         k = {"<c-w>K", "move current window on top"},
--         l = {"<c-w>L", "move current window on right"},
--     },
--     -- s = {
--     --     name = "Saving Files",
--     --     s = {"<cmd>write<CR>", "save current buffer"},
--     --     a = {"<cmd>wa<CR>", "save all buffers"},
--     -- },
--     -- q = {
--     --     name = "Quit",
--     --     q = {"<cmd>q<CR>", "quit current buffer and close window"},
--     --     b = {"<cmd>wqa<CR>", "quit all windows"}
--     -- }
-- }, {prefix = "<leader>"})














-- refresh: auto read file changes nnoremap("<leader>Rf", "<cmd>checktime<CR>")

-- 退出编辑器
-- nnoremap("<C-q>", "<cmd>quitall!<CR>")

-- 滚动并且保持当前行居中屏幕
-- nnoremap("<C-u>", "10kzz")
-- nnoremap("<C-d>", "10jzz")
-- nnoremap("<C-f>", "<C-f>zz")
-- nnoremap("<C-b>", "<C-b>zz")

-- p: 仅粘贴, 而不是粘贴后复制
-- vnoremap("p", '"_c<C-r><C-o>+<Esc>')

-- 修改默认的 $
-- nnoremap("$", "$h")
-- vnoremap("$", "$h")

-- 修改默认的 %
-- nnoremap("%", "0%");
-- nnoremap("<C-i>", "0%i");

-- x 删除而不是剪切
-- nnoremap("x", '"_x')
-- xnoremap("x", '"_x')

-- 选中/删除当前单词
-- nnoremap("vw", "viw")
-- nnoremap("cw", "ciw")
-- nnoremap("dw", "diw")

-- buffer 切换
-- nnoremap("<leader>b1", "<cmd>bfirst<CR>")
-- nnoremap("<leader>b0", "<cmd>blast<CR>")
-- nnoremap("<leader>bb", "<cmd>buffers<CR>")
-- nnoremap("<leader>bs", "<cmd>buffers<CR>")
-- nnoremap("<leader>bd", "<cmd>bprevious|bdelete #<CR>")
-- nnoremap("<leader>bl", "<cmd>vsplit<CR>")
-- nnoremap("<leader>bj", "<cmd>split<CR>")
-- nnoremap("<leader>bn", "<cmd>bnext<CR>")
-- nnoremap("<leader>bp", "<cmd>bprevious<CR>")
-- nnoremap("<leader>bD", "<cmd>%bd|e#|bd#<cr>|'\"<CR>")
-- nnoremap("<leader>bY", '<cmd>%y "<CR>')
-- nnoremap("<S-h>", "<cmd>bprevious<CR>")
-- nnoremap("<S-l>", "<cmd>bnext<CR>")

-- 上下移动选中行
-- xnoremap("<C-j>", "<cmd>move '>+1<CR>gv-gv")
-- xnoremap("<C-k>", "<cmd>move '<-2<CR>gv-gv")
-- xnoremap("<leader>xJ", "<cmd>move '>+1<CR>gv-gv")
-- xnoremap("<leader>xK", "<cmd>move '<-2<CR>gv-gv")

-- 快速输出: javascript console.log
-- nnoremap("<leader>il", [["ayiwoconsole.log("<C-R>a:", <C-R>a);<Esc>]])
-- xnoremap("<leader>il", [["ayoconsole.log("<C-R>a:", <C-R>a);<Esc>]])

-- 快速输出一个指定大小的图片URL使用的是 https://lorem.space/api
-- nnoremap("<leader>ii", [["ayiwohttps://api.lorem.space/image/movie?w=150&h=150<Esc>]])

-- find/file
-- nnoremap("<leader>fo", [[<cmd>silent execute "open ."<CR>]])
-- nnoremap("<leader>fL", [[<cmd>silent execute "open ."<CR>]])
-- nnoremap("<leader>fs", [[<cmd>write<CR>]])

-- git
-- nnoremap("<leader>gi", [[<cmd>silent execute "!git init"<CR>]])

-- helps
-- nnoremap("<leader>hd", "<cmd>call SilentOpenURL('https://neovim.io/doc')<CR>")
-- nnoremap("<leader>hD", "<cmd>call SilentOpenURL('https://github.com/folke/which-key.nvim')<CR>")
-- nnoremap("<leader>hi", "<cmd>call SilentOpenURL('https://github.com/neovim/neovim/issues')<CR>")

-- vim links
-- nnoremap("<leader>oVV",  "<cmd>call SilentOpenURL('https://neovim.io/doc/user/')<CR>")
-- nnoremap("<leader>oVG", "<cmd>call SilentOpenURL('https://github.com/liaohui5/dotfiles')<CR>")
-- nnoremap("<leader>oV0", "<cmd>call SilentOpenURL('https://vim-adventures.com')<CR>")
-- nnoremap("<leader>oV1", "<cmd>call SilentOpenURL('https://vim.rtorr.com')<CR>")
-- nnoremap("<leader>oV2", "<cmd>call SilentOpenURL('https://github.com/chloneda/vim-cheatsheet')<CR>")
-- nnoremap("<leader>oV3", "<cmd>call SilentOpenURL('https://www.w3cschool.cn/vim/4xnd1hsw.html')<CR>")
-- nnoremap("<leader>oV4", "<cmd>call SilentOpenURL('https://yianwillis.github.io/vimcdoc/doc/help.html')<CR>")
-- nnoremap("<leader>oV5", "<cmd>call SilentOpenURL('https://github.com/glepnir/nvim-lua-guide-zh')<CR>")

-- open
-- nnoremap("<leader>ob", "<cmd>call OpenFileWithGoogleChrome()<CR>")
-- nnoremap("<leader>oc", "<cmd>call OpenInVisualStudioCode()<CR>")
-- nnoremap("<leader>ou", "<cmd>call OpenCurrentLineURL()<CR>")
-- nnoremap("<leader>og", "<cmd>call OpenInGithubDesktop()<CR>")

-- quitall
-- nnoremap("<leader>qa", "<cmd>wqa<CR>")

-- nnoremap("<leader>ss", "<cmd>write!<CR>")

-- window
-- nnoremap("<leader>ws", "<cmd>split<CR>")
-- nnoremap("<leader>wv", "<cmd>vsplit<CR>")
-- nnoremap("<leader>wo", "<cmd>only<CR>")

-- text
-- nnoremap("<leader>xo", "<cmd>call OpenCurrentLineURL()<CR>")

-- yank
-- nnoremap("<leader>yn", "<cmd>let @+ = expand('%:t')<CR>")
-- nnoremap("<leader>yp", "<cmd>let @+ = expand('%:p')<CR>")
-- nnoremap("<leader>yp", "<cmd>let @+ = expand('%')<CR>")


-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │                                     Ctrl                                     │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
-- C-q   : quit neovim
-- C-e   : toggle file explorer
-- C-p   : telescope search
-- C-t   : toggle terminal
-- C-g   : toggle lazygit
-- C-n   : toggle vifm(file manager like ranger)
-- C-F12 : toggle zellij terminal
