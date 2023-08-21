return {
  -- ╭──────────────────────────────────────────────────────────────────────────────╮
  -- │                                  文件查找                                    │
  -- ╰──────────────────────────────────────────────────────────────────────────────╯
  -- ------------
  -- -文件查找器-
  -- ------------
  {
    'nvim-telescope/telescope.nvim', -- tag = '0.1.2',
    commit = vim.fn.has("nvim-0.9.0") == 0 and "057ee0f8783" or nil,
    version = false,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-ui-select.nvim', -- 用于neovim-session-manager
      -- --------------
      -- -加快搜索速度-
      -- --------------
      {'nvim-telescope/telescope-fzf-native.nvim', build = 'make'},
      -- ----------
      -- -路径搜索-
      -- ----------
      "nvim-telescope/telescope-file-browser.nvim",
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      telescope.setup({
        defaults = {
          mappings = {
            i = {
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-q>"] = actions.close,
              ["<A-q>"] = actions.close,  -- NOTE: 按起来更舒服一些
              -- ["<esc>"] = actions.close,  --  NOTE: 不要映射esc，因为还要用它来进行i和n的转换
            },
            n = {
              ["<C-c>"] = false,
            },
          }
        },
        extensions = {
          fzf = {
            fuzzy = true,                    -- false will only do exact matching
            override_generic_sorter = true,  -- override the generic sorter
            override_file_sorter = true,     -- override the file sorter
            case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                             -- the default case_mode is "smart_case"
          },
          file_browser = {
            theme = "ivy",
            -- disables netrw and use telescope-file-browser in its place
            hijack_netrw = false,
          },
        }
      })
      telescope.load_extension("fzf")
      telescope.load_extension("file_browser")
      telescope.load_extension("ui-select")
      -- telescope.load_extension("noice")
    end,
    cmd = "Telescope",
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Lists files in your current working directory" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "search for a string in your current working directory" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Lists available help tags" },
      { "<leader>fo", "<cmd>Telescope oldfiles<cr>", desc = "Lists previously open files" },

      { "<leader>fF", "<cmd>Telescope file_browser<cr>", desc = "Telescope file browser" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Lists open buffers in current neovim instance" },
      { "<leader>fc", function() require("telescope.builtin")["colorscheme"]({enable_preview = false}) end, desc = "Colorscheme with preview" },
      { "<leader>fu", function() require("telescope.builtin")["lsp_document_symbols"]({
        symbols = { "Class", "Function", "Method", "Constructor", "Interface", "Module", "Struct", "Trait", "Field", "Property"},
      }) end, desc = "Goto Symbol (Workspace)" },
      { "<leader>fU", function() require("telescope.builtin")["lsp_dynamic_workspace_symbols"]({
        symbols = { "Class", "Function", "Method", "Constructor", "Interface", "Module", "Struct", "Trait", "Field", "Property"},
      }) end, desc = "Goto Symbol (Workspace)" }
    }
  },


  -- {
  --   "nvim-telescope/telescope-file-browser.nvim",
  --   lazy = true,
  --   keys = {
  --     { "<leader>fF", "<cmd>Telescope file_browser<cr>", desc = "Telescope file browser" },
  --   }
  -- },

  -- ------------------------------------
  -- -将vim.ui.select交由telescope来控制-
  -- ------------------------------------
  --
  -- { 'nvim-telescope/telescope-ui-select.nvim' , lazy = true },
}
