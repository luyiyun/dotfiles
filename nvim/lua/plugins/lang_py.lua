return {
  -- 可以选择特定的python环境
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim" },
    event = "VeryLazy", -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
    keys = {
      { "<leader>vs", "<cmd>:VenvSelect<cr>", desc = "select python enviroment" },
      -- key mapping for directly retrieve from cache. You may set autocmd if you prefer the no hand approach
      -- "<leader>vc", "<cmd>:VenvSelectCached<cr>"
    },
    opts = {
      anaconda_path = "$HOME/mambaforge/envs/",
    }
  }
}
