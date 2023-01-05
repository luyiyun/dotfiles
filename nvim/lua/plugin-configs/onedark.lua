-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │  onedark 主题颜色                                                            │
-- │  docs: https://github.com/navarasu/onedark.nvim                              │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
local onedark = loadModule("onedark", "plugin-configs")

onedark.setup({
  style                = 'dark',
  transparent          = false,
  term_colors          = true,
  ending_tildes        = false,
  cmp_itemkind_reverse = false,
  toggle_style_key     = nil,
  toggle_style_list    = {
    'dark',
    'darker',
    'cool',
    'deep',
    'warm',
    'warmer',
    'light',
  },
  code_style           = {
    comments  = 'none',
    keywords  = 'none',
    functions = 'none',
    strings   = 'none',
    variables = 'none'
  },
  -- colors: https://github.com/navarasu/onedark.nvim/blob/master/lua/onedark/palette.lua
  colors               = {},
  -- highlights: https://github.com/navarasu/onedark.nvim/blob/master/lua/onedark/highlights.lua
  highlights           = {},
  diagnostics          = {
    darker     = true,
    undercurl  = true,
    background = true,
  },
});

-- 使用 onedark 主题
onedark.load();
