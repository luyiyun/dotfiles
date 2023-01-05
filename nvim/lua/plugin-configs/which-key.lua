-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │ 书签管理                                                                     │
-- │ docs: https://github.com/folke/which-key.nvim                                │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
local wk = loadModule("which-key", "plugin-configs");

wk.setup({
  ignore_missing     = false, -- 忽略没有wk.register 的快捷键映射
  show_help          = true,  -- 显示帮助信息
  -- 设置哪些按键可以触发 which-key, 修改这个设定可能会让一些插件
  -- 的功能失效比如: nvim-surround, 如果没有 d 提示, ds" 就会失效
  -- 设置为 auto 代表所有键都显示提示
  -- triggers = { "<leader>", "g", "d", "y" ,"s", "v", "\"", "'" },
  triggers           = "auto",
  operators      = {
    gc = "Comments",
  },
  triggers_blacklist = {
    -- 禁止处罚 which-key 的按钮
    -- i:insert模式 v:visual模式
    i = { "j", "k" },
    v = { "j", "k" },
  },
  hidden             = {
    "<silent>",
    "<cmd>",
    "<Cmd>",
    "<CR>",
    "call",
    "lua",
    "^:",
    "^ ",
    "<Plug>",
  },
  plugins        = {
    -- 内置插件设置
    marks     = true, -- 查看所有标记用 ' 和 ` 触发
    registers = true, -- 查看所有寄存器(registers) 用 " 触发
    spelling  = {     -- 单词检测
      enabled = false,
    },
    presets   = {
      -- which-key 内置的按键提示
      operators    = true,
      motions      = true,
      text_objects = true,
      windows      = true,
      nav          = true,
      z            = true,
      g            = true,
    },
  },
  key_labels     = {
    -- 特殊按键显示的样式
    ["<space>"] = "<Space>",
    ["<cr>"]    = "<Enter>",
    ["<tab>"]   = "<Tab>",
  },
  icons          = {
    -- 图标
    breadcrumb = "↣",
    separator  = "➤",
    group      = "+",
  },
  popup_mappings = {
    -- 滚动面板
    scroll_down = "<c-d>", -- 如果按键太多, 向下滚动
    scroll_up   = "<c-u>", -- 如果按键太多, 向下滚动
  },
  window         = {
    -- 窗口样式
    border   = "none", -- none | single | double | shadow
    position = "bottom", -- bottom | top
    margin   = { 0, 0, 0, 0 }, -- extra window margin [top, right, bottom, left]
    padding  = { 1, 0, 1, 0 }, -- extra window padding [top, right, bottom, left]
    winblend = 0
  },
  layout         = {
    -- 布局
    height  = { min = 4, max = 30 },
    width   = { min = 20, max = 50 },
    spacing = 4,
    align   = "center", -- left | center | right
  },
});
