return {
  -- ----------
  -- -颜色主题-
  -- ----------
  {
    "navarasu/onedark.nvim",
    lazy = true,
    opts = {
      style                = 'dark',
      transparent          = false,
      term_colors          = true,
      ending_tildes        = false,
      cmp_itemkind_reverse = false,
      toggle_style_key     = "<leader>fc",
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
    }
  },
  { "RRethy/nvim-base16", lazy = true},
  { "tanvirtin/monokai.nvim", lazy = true},
  { 'marko-cerovac/material.nvim' , lazy = true},
  { "catppuccin/nvim", name = "catppuccin" , lazy = true},
  -- {"folke/tokyonight.nvim", lazy = true},
}
