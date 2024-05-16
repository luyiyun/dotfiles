return {
  -- 可以选择特定的python环境
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim" },
    event = "VeryLazy", -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
    keys = {
      { "<leader>vs", "<cmd>:VenvSelect<cr>", desc = "select python enviroment" },
      -- key mapping for directly retrieve from cache. You may set autocmd if you prefer the no hand approach
      { "<leader>vc", "<cmd>:VenvSelectCached<cr>", desc = "selec python enviroment cached" },
      { "<leader>vd", function() require("venv-selector").deactivate_venv() end, desc = "python enviroment deactivate" }
    },
    opts = {
      anaconda_path = osinfo() == "WIN" and "C:\\Softwares\\miniforge\\envs" or "$HOME/mambaforge/envs/",
      search = false,
      search_workspace = false,
    }
  }
}
