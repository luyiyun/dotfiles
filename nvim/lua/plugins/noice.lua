-- TODO: 重新设置一下各个插件的依赖关系
return {
  -- ---------------------
  -- -cmdline和notify美化-
  -- ---------------------
  {
    "folke/noice.nvim",
    -- config = function() require("plugin-configs.noice") end,
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
      {'nvim-telescope/telescope.nvim', tag = '0.1.0'},
    },
    cmd = "Noice",
    keys = {
      {"<leader>fn", "<cmd>Noice telescope<cr>", desc = "List noice"}
    },
    config = function () require("noice").setup() end
  },
}
