-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │ 顶栏插件配置和管理                                                           │
-- │ docs: https://github.com/romgrk/barbar.nvim                                  │
-- ╰──────────────────────────────────────────────────────────────────────────────╯

-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │                                    快捷键设置                                │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Move to previous/next
map('n', '<A-h>', '<Cmd>BufferPrevious<CR>', opts)
map('n', '<A-l>', '<Cmd>BufferNext<CR>', opts)
-- Re-order to previous/next
map('n', '<A-,>', '<Cmd>BufferMovePrevious<CR>', opts)
map('n', '<A-.>', '<Cmd>BufferMoveNext<CR>', opts)
-- Goto buffer in position...
map('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', opts)
map('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', opts)
map('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', opts)
map('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', opts)
map('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', opts)
map('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', opts)
map('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', opts)
map('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', opts)
map('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', opts)
map('n', '<A-0>', '<Cmd>BufferLast<CR>', opts)
-- Pin/unpin buffer
map('n', '<A-p>', '<Cmd>BufferPin<CR>', opts)
-- Close buffer
map('n', '<A-q>', '<Cmd>BufferClose<CR>', opts)
-- map('n', '<A-o>', '<Cmd>BufferCloseAllButCurrent<CR>', opts)  -- NOTE: 总是容易误触
-- Wipeout buffer
--                 :BufferWipeout
-- Close commands
--                 :BufferCloseAllButCurrent
--                 :BufferCloseAllButPinned
--                 :BufferCloseAllButCurrentOrPinned
--                 :BufferCloseBuffersLeft
--                 :BufferCloseBuffersRight


local wk = loadModule("which-key", "plugins-config");
wk.register({
    ["<leader>b"] = {
        name = "Pick or order Buffers",
        p = {"<Cmd>BufferPick<CR>", "Magic buffer-picking mode"},
        b = {"<Cmd>BufferOrderByBufferNumber<CR>", "Sort automatically by Buffer names"},
        d = {"<Cmd>BufferOrderByDirectory<CR>", "Sort automatically by Directory"},
        l = {"<Cmd>BufferOrderByLanguage<CR>", "Sort automatically by Language"},
        w = {"<Cmd>BufferOrderByLanguage<CR>", "Sort automatically by Window numbers"},
    },
})

-- Other:
-- :BarbarEnable - enables barbar (enabled by default)
-- :BarbarDisable - very bad command, should never be used

-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │                                    其他配置                                  │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
-- 当目录树打开时的解决方案：
-- 这里我们改用专属于nvim-tree的特定解决方案
local nvim_tree_events = loadModule('nvim-tree.events', 'plugin-configs/barbar')
local bufferline_api = loadModule('bufferline.api', 'plugin-configs/barbar')
local bufferline = loadModule("bufferline", "plugin-configs/barbar")
-- local hl = loadModule("bufferline.utils", "plugin-configs/barbar").hl
local icons = loadModule("icons", "plugin-configs/barbar")


local function get_tree_size()
  return require'nvim-tree.view'.View.width
end

nvim_tree_events.subscribe('TreeOpen', function()
  bufferline_api.set_offset(get_tree_size())
end)

nvim_tree_events.subscribe('Resize', function()
  bufferline_api.set_offset(get_tree_size())
end)

nvim_tree_events.subscribe('TreeClose', function()
  bufferline_api.set_offset(0)
end)

-- 通用解决方案:
-- local bufferline = loadModule("bufferline", "plugins-config");
-- local barApi = loadModule("bufferline.api", "plugin-configs");
--
-- -- 当侧边栏打开时, 设置 barbar 的左边边距
-- vim.api.nvim_create_autocmd("BufWinEnter", {
--   pattern = "*",
--   callback = function()
--     if vim.bo.filetype == "NvimTree" then
--       local offsetWidth = 33;
--       barApi.set_offset(offsetWidth, string.rep(" ", 10) .. "File Explorer");
--     end
--   end
-- });
--
-- -- 当侧边栏关闭时设置 barbar 的左边边距
-- vim.api.nvim_create_autocmd("BufWinLeave", {
--   pattern = "*",
--   callback = function()
--     if vim.fn.expand("<afile>"):match("NvimTree") then
--       barApi.set_offset(0);
--     end
--   end
-- });

bufferline.setup({
  -- Enable/disable animations
  animation = true,

  -- Enable/disable auto-hiding the tab bar when there is a single buffer
  auto_hide = false,

  -- Enable/disable current/total tabpages indicator (top right corner)
  tabpages = true,

  -- Enable/disable close button
  closable = true,

  -- Enables/disable clickable tabs
  --  - left-click: go to buffer
  --  - middle-click: delete buffer
  clickable = true,

  -- Enables / disables diagnostic symbols
  diagnostics = {
    -- you can use a list NOTE: use default icons
    -- {enabled = true}, -- ERROR
    -- {enabled = false}, -- WARN
    -- {enabled = false}, -- INFO
    -- {enabled = true},  -- HINT

    -- OR `vim.diagnostic.severity`
    [vim.diagnostic.severity.ERROR] = {enabled = true, icon = icons.diagnostics.BoldError},
    [vim.diagnostic.severity.WARN] = {enabled = false, icon = icons.diagnostics.BoldWarning},
    [vim.diagnostic.severity.INFO] = {enabled = false, icon = icons.diagnostics.BoldInformation},
    [vim.diagnostic.severity.HINT] = {enabled = true, icon = icons.diagnostics.BoldHint},
  },

  -- Excludes buffers from the tabline
  exclude_ft = {},
  exclude_name = {},

  -- Hide inactive buffers and file extensions. Other options are `alternate`, `current`, and `visible`.
  -- extensions = true会在bar中隐藏后缀
  -- inactive = true会将inactive的buffer隐藏，也就是当前页面以外的所有buffers
  hide = {extensions = false, inactive = false},

  -- Disable highlighting alternate buffers
  highlight_alternate = false,

  -- Enable highlighting visible buffers
  highlight_visible = true,

  -- Enable/disable icons
  -- if set to 'numbers', will show buffer index in the tabline
  -- if set to 'both', will show buffer index and icons in the tabline
  icons = true,

  -- If set, the icon color will follow its corresponding buffer
  -- highlight group. By default, the Buffer*Icon group is linked to the
  -- Buffer* group (see Highlighting below). Otherwise, it will take its
  -- default value as defined by devicons.
  icon_custom_colors = false,

  -- Configure icons o1n the bufferline.
  icon_separator_active = icons.ui.BoldLineLeft,
  icon_separator_inactive = icons.ui.BoldLineLeft,  -- '▎',
  icon_close_tab = icons.ui.Close,  -- '',
  icon_close_tab_modified = icons.ui.Circle, -- '●',
  icon_pinned = icons.ui.Pin, -- '車',

  -- If true, new buffers will be inserted at the start/end of the list.
  -- Default is to insert after current buffer.
  insert_at_end = true,
  insert_at_start = false,

  -- Sets the maximum padding width with which to surround each tab
  maximum_padding = 1,

  -- Sets the minimum padding width with which to surround each tab
  minimum_padding = 1,

  -- Sets the maximum buffer name length.
  maximum_length = 30,

  -- If set, the letters for each buffer in buffer-pick mode will be
  -- assigned based on their name. Otherwise or in case all letters are
  -- already assigned, the behavior is to assign letters in order of
  -- usability (see order below)
  semantic_letters = true,

  -- New buffer letters are assigned in this order. This order is
  -- optimal for the qwerty keyboard layout but might need adjustement
  -- for other layouts.
  letters = 'asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP',

  -- Sets the name of unnamed buffers. By default format is "[Buffer X]"
  -- where X is the buffer number. But only a static string is accepted here.
  no_name_title = nil,
})
