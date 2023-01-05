-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │ 侧边栏目录树                                                                 │
-- │ docs: https://github.com/kyazdani42/nvim-tree.lua                            │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
local events   = loadModule("nvim-tree.events", "plugin-configs");
local nvimtree = loadModule("nvim-tree", "plugin-configs");
local wk = loadModule("which-key", "plugin-configs");


wk.register({
    name = "Nvim folder tree",
    f = {"<cmd>NvimTreeFocus<CR>", "focus in explorer[nvim-tree]"},
    t = {"<cmd>NvimTreeToggle<CR>", "toggle file explorer[nvim-tree]"},
    r = {"<cmd>NvimTreeRefresh<CR>", "refresh file explorer[nvim-tree]"},
    o = {"<cmd>NvimTreeFindFileToggle<CR>", "toggle file finder explorer[nvim-tree]"},
}, {prefix = "<leader>t"})

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw       = 1
vim.g.loaded_netrwPlugin = 1


nvimtree.setup({
  open_on_setup       = false, -- 启动时直接打开
  disable_netrw       = true,
  hijack_netrw        = true,
  update_cwd          = true,
  log                 = {
    enable = false,
  },
  update_focused_file = {
    enable     = true,
    update_cwd = true,
  },
  git                 = {
    enable       = false,
    ignore       = true,
    timeout      = 400,
    show_on_dirs = false,
  },
  filters             = {
    dotfiles = false,
    custom   = {},
    exclude  = {
      "node_modules",
    },
  },
  filesystem_watchers = {
    enable = true,
    debounce_delay = 100,
  },
  actions             = {
    open_file = {
      resize_window = false,
      quit_on_open = true,
    },
    remove_file = {
        close_window = true,
    }
  },
  system_open         = {
    cmd = "open",
  },
  view                = {
    number           = false,
    relativenumber   = false,
    width            = 32,
    signcolumn       = "yes",
    side             = "left",
    hide_root_folder = true,
    mappings         = {
      custom_only = true,
      -- 绑定快捷键
      list        = {
        { key = "o", action = "edit" }, -- 打开并编辑
        { key = "<CR>", action = "edit" }, -- 打开并编辑
        { key = "<C-\\>", action = "system_open" }, -- 用系统 open 命令打开
        { key = "v", action = "vsplit" }, -- 左右拆分窗口并打开编辑
        { key = "i", action = "toggle_ignored" }, -- 切换忽略
        { key = ".", action = "toggle_dotfiles" }, -- 切换隐藏文件是否可见
        { key = "R", action = "refresh" }, -- 刷新
        { key = "a", action = "create" }, -- 创建文件/目录(/结尾就是目录)
        { key = "r", action = "rename" }, -- 重命名
        { key = "x", action = "remove" }, -- 删除
        { key = "d", action = "cut" }, -- 剪切
        { key = "y", action = "copy" }, -- 复制
        { key = "p", action = "paste" }, -- 粘贴
        { key = "Yn", action = "copy_name" }, -- 复制文件名
        { key = "Yp", action = "copy_path" }, -- 否则文件路径
        { key = "YP", action = "copy_absolute_path" }, -- 复制文件绝对路径
        { key = "I", action = "toggle_file_info" }, -- 查看文件信息
        { key = { "]" }, action = "cd" }, -- 切换目录
        { key = { "[" }, action = "dir_up" }, -- 切换到上级目录
        -- { key = "n", action = "tabnew" }, -- 不知道干嘛的
      }
    },
  },
  renderer            = {
    highlight_git          = true,
    highlight_opened_files = "none",
    indent_markers         = {
      enable = false,
    },
    icons                  = {
      webdev_colors = true,
      show = {
        file         = true,
        folder       = true,
        folder_arrow = false,
        git          = true,
      },
      glyphs = {
        default = "",
        symlink = "",
      },
    },
  },
})

-- 创建文件时, 自动编辑这个文件
events.on_file_created(function(file) vim.cmd("edit " .. file.fname) end)

