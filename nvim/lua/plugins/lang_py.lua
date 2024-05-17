return {
  -- 可以选择特定的python环境
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim" },
    event = "VeryLazy", -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
    branch = "regexp",
    keys = {
      { "<leader>vs", "<cmd>:VenvSelect<cr>",                                    desc = "select python enviroment" },
      -- key mapping for directly retrieve from cache. You may set autocmd if you prefer the no hand approach
      { "<leader>vd", function() require("venv-selector").deactivate_venv() end, desc = "python enviroment deactivate" }
    },
    config = function()
      require("venv-selector").setup({
        settings = {
          options = {
            enable_default_searches = false,
          },
          search = {
            win_miniforge = {
              command = "fd ^python.exe$ C:/Softwares/miniforge/envs -E Lib -E Scripts",
              -- command = "fd -p ^C:\\Softwares\\miniforge\\envs\\.*?\\python.exe$ ",
              -- on_tetescope_result_callback = function(filename)
              --   return filename:gsub("\\python.exe", ""):gsub("C:\\Softwares\\miniforge\\envs\\", "")
              -- end
            },
            linux_mambaforge = {
              command = "fd ^python$ $HOME/mambaforge/envs/ -E Lib -E Scripts",
            }
          }
        }

      })
    end
  }
}
