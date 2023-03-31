--  .----------------.  .----------------.  .----------------.  .----------------.  .----------------.  .-----------------. .----------------.
--  | .--------------. || .--------------. || .--------------. || .--------------. || .--------------. || .--------------. || .--------------. |
--  | |     ____     | || |   ______     | || |  _________   | || |     _____    | || |     ____     | || | ____  _____  | || |    _______   | |
--  | |   .'    `.   | || |  |_   __ \   | || | |  _   _  |  | || |    |_   _|   | || |   .'    `.   | || ||_   \|_   _| | || |   /  ___  |  | |
--  | |  /  .--.  \  | || |    | |__) |  | || | |_/ | | \_|  | || |      | |     | || |  /  .--.  \  | || |  |   \ | |   | || |  |  (__ \_|  | |
--  | |  | |    | |  | || |    |  ___/   | || |     | |      | || |      | |     | || |  | |    | |  | || |  | |\ \| |   | || |   '.___`-.   | |
--  | |  \  `--'  /  | || |   _| |_      | || |    _| |_     | || |     _| |_    | || |  \  `--'  /  | || | _| |_\   |_  | || |  |`\____) |  | |
--  | |   `.____.'   | || |  |_____|     | || |   |_____|    | || |    |_____|   | || |   `.____.'   | || ||_____|\____| | || |  |_______.'  | |
--  | |              | || |              | || |              | || |              | || |              | || |              | || |              | |
--  | '--------------' || '--------------' || '--------------' || '--------------' || '--------------' || '--------------' || '--------------' |
--   '----------------'  '----------------'  '----------------'  '----------------'  '----------------'  '----------------'  '----------------'
-- 定义neovim的部分选项
local opt = vim.opt

-----------------------------------------------------------------------------------------
-- 显示设置
-----------------------------------------------------------------------------------------
-- 在标题栏显示标题（即文件名和路径）
opt.title = true
-- 高亮当前行
opt.cursorline = true
-- 行号
opt.number = true
-- 相对行号
opt.relativenumber = false
-- 不显示空白字符，listchars来决定这些字符有哪些
opt.list = false
-- 显示图标栏，在行号的左侧显示一些图标来表示error或break
opt.signcolumn = 'yes'
-- 不自动换行显示
opt.wrap = false
-- 当键入括号的右半侧时，自动高亮一下整个括号
opt.showmatch = true
-- showmatch的时间，单位是0.1s
opt.matchtime = 1
-- 使用24-bit RGB colors，一些插件需要开启
opt.termguicolors = true
-- 隐藏命令行
opt.cmdheight = 0
-- 判定为组合键的间隔时间
opt.timeoutlen = 150


-----------------------------------------------------------------------------------------
-- 编辑设置
-----------------------------------------------------------------------------------------


-----------------------------------------------------------------------------------------
-- 移动(motion)设置
-----------------------------------------------------------------------------------------
-- ctrl-d/u时的屏幕滚动的行数，默认是半个page
-- opt.scrolloff = 5
-- 横向滚动时的行数
-- opt.sidescrolloff = 5


-----------------------------------------------------------------------------------------
-- 文件字符编码
-----------------------------------------------------------------------------------------
-- vim内部和RPC通讯时使用的字符编码，总是utf-8，其实不需要设置
opt.encoding = 'utf-8'
-- 当前buffer中文件内容的储存编码。注意，只有当fileencodings为
-- 空时，读取文件时才会使用fileencoding中的设置。当writing的时候
-- 生效。默认为空，默认为空时使用utf-8
opt.fileencoding = 'utf-8'
-- 读取文件时，vim会一个接一个的来用fileencodings中的编码来解码
-- 存在的文件，如果读取成功，将会将其设置为fileencoding的编码
opt.fileencodings = { "utf-8", "latin1", "ucs-bom", "cp936" }
-- 没有找到termencoding的options
-- opt.termencoding    = "utf-8"
-- vim.scriptencoding = 'utf-8'


-----------------------------------------------------------------------------------------
-- 制表符和缩进设置（制表符的设置通过autocmd来进行）
-----------------------------------------------------------------------------------------
-- 文件中制表符所占用的空格数量
opt.tabstop = 2
-- 编辑文件时，新输入的制表符所对应的空格数量
opt.softtabstop = 2
-- 每次缩进使用的空格数量，当使用>>或<<时
opt.shiftwidth = 2
-- insert mode下，使用空格来替换制表符，如果想要插入真正的制表符，请使用ctrl-v<TAB>
opt.expandtab = true

-- NOTE: 这些缩进设置都不满足我的要求，这里我直接使用treesitter的缩进，效果更好
-- 进行c-like的自动缩进（据说会影响性能，先不开启了)
-- 当开始一个新的行时，自动应用上一行的缩进，默认开启
opt.autoindent = false
opt.smartindent = false
opt.cindent = false


-----------------------------------------------------------------------------------------
-- 剪切板设置
-----------------------------------------------------------------------------------------
-- 当包含unnamedplus或unnamed时（暂时没有发现这两个的差别）
-- vim内的复制/粘贴会依赖''、0、*、+这4个registor。
-- *和+就是系统剪切板，在外部复制的内容也会放到这两个registor内
-- 因此我们也可以直接使用p来将外部复制的内容粘贴到vim内
opt.clipboard:append ("unnamedplus")


-----------------------------------------------------------------------------------------
-- 搜索设置
-----------------------------------------------------------------------------------------
-- 高亮搜索结果
opt.hlsearch = true
-- 高亮模式搜索结果
opt.incsearch = true
-- 在搜索时忽略大小写
opt.ignorecase = true
-- 如果搜索的内容存在大写，则忽略ignorecase的设置，依然使用大小写敏感的搜索模式
opt.smartcase = true


-----------------------------------------------------------------------------------------
-- 鼠标设置
-----------------------------------------------------------------------------------------
-- 在所有模式下启用鼠标
opt.mouse = 'a'


-----------------------------------------------------------------------------------------
-- 文件读取和储存设置
-----------------------------------------------------------------------------------------
-- local config_dir = vim.fn.stdpath("config")
-- local undo_dir, backup_dir
-- local os = osinfo()
-- if os == "WIN" then
--     undo_dir = config_dir.."\\undo"
--     backup_dir = config_dir.."\\backup"
-- else
--     undo_dir = config_dir.."/undo"
--     backup_dir = config_dir.."/backup"
-- end
-- 文件从外部被改变时，自动重新读取它
opt.autoread = true
-- 在undodir内自动创建undo file，储存undo history
-- NOTE: 不创建undo文件，不然会让文件很乱
opt.undofile = false
-- 设置undo file的储存路径
-- opt.undodir = { undo_dir, "." }
-- 不创建swapfile
-- vim会先将用户对文件的修改储存在swap文件中，然后再保存到文件中，当异常退出时，可以
-- 通过swap来恢复自己临时的修改。
-- swap的一个缺点是，如果有超大文件，会撑爆储存。
opt.swapfile = false
-- 创建备份文件
opt.writebackup = true
-- 备份文件路径，.表示当前文件所在路径
opt.backupdir = {"."}


-----------------------------------------------------------------------------------------
-- 文件读取和储存设置
-----------------------------------------------------------------------------------------
-- 上下拆分窗口时，新窗口位于下方
opt.splitbelow = true
-- 左右拆分窗口时，新窗口位于右方
opt.splitright = true


-----------------------------------------------------------------------------------------
-- 不同的文件类型使用不同的设置
-----------------------------------------------------------------------------------------
-- 这里我们使用filetype插件来实现相同的功能，速度会更快
-- 但是实际上我们并没有在filetype插件中进行设置，也实现了这个功能（即python的tab是4，其他是2）?????
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = '*',
--   callback = function(args)
--       if vim.endswith(args.file, "py") then
--           vim.opt_local.tabstop = 4  -- 文件中制表符所占用的空格数量
--           vim.opt_local.softtabstop = 4  -- 编辑文件时，新输入的制表符所对应的空格数量
--           vim.opt_local.shiftwidth = 4  -- 每次缩进使用的空格数量，当使用>>或<<时
--       else
--           vim.opt_local.tabstop = 2  -- 文件中制表符所占用的空格数量
--           vim.opt_local.softtabstop = 2  -- 编辑文件时，新输入的制表符所对应的空格数量
--           vim.opt_local.shiftwidth = 2  -- 每次缩进使用的空格数量，当使用>>或<<时
--       end
--   end
-- })


-----------------------------------------------------------------------------------------
-- 其他设置
-----------------------------------------------------------------------------------------
vim.bo.autoread = true
