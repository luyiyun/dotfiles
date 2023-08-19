return {
  -- ╭──────────────────────────────────────────────────────────────────────────────╮
  -- │                                 快捷键菜单                                   │
  -- ╰──────────────────────────────────────────────────────────────────────────────╯
  -- NOTE: 只有加入which-key才能激活lazy.vim中的keys参数
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  }
}
