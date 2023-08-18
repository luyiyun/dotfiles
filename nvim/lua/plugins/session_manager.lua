-- -------------
-- -session管理-
-- -------------
return {
  -- NOTE: lspsaga报错
  -- TODO: 现在有个问题，nvim无法打开当前路径下的session，而且这样打开的buffer没有行号
  {
    "Shatur/neovim-session-manager",
    event = "VeryLazy",
    keys = {
      { "<leader>fs", "<cmd>SessionManager load_session<cr>", desc = "Telescope sessions" },
    },
    config = function ()
      local session_manager = require("session_manager")
      session_manager.setup({})

      local config_group = vim.api.nvim_create_augroup("SessionGroup", {})

      -- save session every time a buffer is written
      vim.api.nvim_create_autocmd({"BufWritePost"}, {
        group = config_group,
        callback = function ()
          if vim.bo.filetype ~= 'git'
            and not vim.bo.filetype ~= 'gitcommit'
            and not vim.bo.filetype ~= 'gitrebase'
            then session_manager.autosave_session() end
        end
      })
    end
  },

  -- NOTE: 无法和telescope配合
  -- {
  --   "folke/persistence.nvim",
  --   event = "BufReadPre",
  --   opts = { options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp" } },
  --   -- stylua: ignore
  --   keys = {
  --     { "<leader>qs", function() require("persistence").load() end, desc = "Restore Session" },
  --     { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
  --     { "<leader>qd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
  --   },
  -- },

  -- NOTE: 有时候会让左边的行号丢失
  -- {
  --   "olimorris/persisted.nvim",
  --   event = "VeryLazy",
  --   dependencies = "nvim-telescope/telescope.nvim",
  --   keys = {
  --     {"<leader>fs", "<cmd>Telescope persisted<cr>", desc = "Telescope session manager"},
  --   },
  --   config = function()
  --     require("persisted").setup({
  --       autoload = true,
  --     })
  --     require("telescope").load_extension("persisted")
  --   end,
  -- }

}
