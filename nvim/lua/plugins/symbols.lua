return {
  -- {
  --   "simrat39/symbols-outline.nvim",
  --   event = "VeryLazy",
  --   opts = {},
  --   keys = { { "<leader>s", "<cmd>SymbolsOutline<cr>", "Toggle symbols outline" }, }
  -- },
  -- {
  --   'stevearc/aerial.nvim',
  --   opts = {
  --     -- optionally use on_attach to set keymaps when aerial has attached to a buffer
  --     on_attach = function(bufnr)
  --       -- Jump forwards/backwards with '{' and '}'
  --       vim.keymap.set('n', '[', '<cmd>AerialPrev<CR>', { buffer = bufnr })
  --       vim.keymap.set('n', ']', '<cmd>AerialNext<CR>', { buffer = bufnr })
  --     end
  --   },
  --   -- Optional dependencies
  --   dependencies = {
  --     "nvim-treesitter/nvim-treesitter",
  --     "nvim-tree/nvim-web-devicons"
  --   },
  --   keys = { { "<leader>s", "<cmd>AerialToggle!<cr>", "Toggle symbols outline" }, }
  -- }
  --
  --
  ------------------------------------------------------------------
  -- a VS Code like winbar in order to get LSP context and file name
  ------------------------------------------------------------------
  {
    "utilyre/barbecue.nvim",
    event = "VeryLazy",
    name = "barbecue",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    opts = {
      -- configurations go here
    },
  },

  ------------------------------------------------------------------
  -- lsp symbols navigator
  ------------------------------------------------------------------
  {
    "SmiteshP/nvim-navbuddy",
    event = "VeryLazy",
    dependencies = {
      "neovim/nvim-lspconfig",
      "SmiteshP/nvim-navic",
      "MunifTanjim/nui.nvim",
      "numToStr/Comment.nvim",        -- Optional
      "nvim-telescope/telescope.nvim" -- Optional
    },
    keys = {
      { "<leader>s", "<cmd>Navbuddy<cr>", "symbols outline" },
    },
    config = function()
      local navbuddy = require("nvim-navbuddy")
      -- vim.api.nvim_create_autocmd("LspAttach", {
      --   callback = function(args)
      --     local buffer = args.buf
      --     local client = vim.lsp.get_client_by_id(args.data.client_id)
      --     navbuddy.attach(client, buffer)
      --   end
      -- })
      navbuddy.setup({
        lsp = {
          auto_attach = true,
          preference = { "pyright", "lua_ls", "yamlls" }
        }
      })
    end
  }

}
