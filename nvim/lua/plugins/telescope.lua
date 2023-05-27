return {
  -- ╭──────────────────────────────────────────────────────────────────────────────╮
  -- │                                  文件查找                                    │
  -- ╰──────────────────────────────────────────────────────────────────────────────╯
  -- ------------
  -- -文件查找器-
  -- ------------
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-ui-select.nvim',
      -- --------------
      -- -加快搜索速度-
      -- --------------
      {'nvim-telescope/telescope-fzf-native.nvim', build = 'make'},
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
            -- NOTE: 自己设置的mappings总是出问题，还是使用默认的吧
            -- - `<cr>`: opens the currently selected file, or navigates to the
            --   currently selected directory
            -- - `<A-c>/c`: Create file/folder at current `path` (trailing path
            --   separator creates folder)
            -- - `<A-r>/r`: Rename multi-selected files/folders
            -- - `<A-m>/m`: Move multi-selected files/folders to current `path`
            -- - `<A-y>/y`: Copy (multi-)selected files/folders to current `path`
            -- - `<A-d>/d`: Delete (multi-)selected files/folders
            -- - `<C-o>/o`: Open file/folder with default system application
            -- - `<C-g>/g`: Go to parent directory
            -- - `<C-e>/e`: Go to home directory
            -- - `<C-w>/w`: Go to current working directory (cwd)
            -- - `<C-t>/t`: Change nvim's cwd to selected folder/file(parent)
            -- - `<C-f>/f`: Toggle between file and folder browser
            -- - `<C-h>/h`: Toggle hidden files/folders
            -- - `<C-s>/s`: Toggle all entries ignoring `./` and `../`
            -- mappings = {
            --   ["i"] = { },
            --   ["n"] = { }
            -- },
          },
          -- ["ui-select"] = {
          --   require("telescope.themes").get_dropdown {
          --     -- even more opts
          --   }
          -- },
        }
      })
      telescope.load_extension("fzf")
      telescope.load_extension("file_browser")
      telescope.load_extension("ui-select")
      telescope.load_extension("noice")
    end,
    cmd = "Telescope",
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Lists files in your current working directory" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "search for a string in your current working directory" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Lists open buffers in current neovim instance" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Lists available help tags" },
      { "<leader>fo", "<cmd>Telescope oldfiles<cr>", desc = "Lists previously open files" },
      { "<leader>fF", "<cmd>Telescope file_browser<cr>", desc = "Telescope file browser" },
      { "<leader>fs", "<cmd>SessionManager load_session<cr>", desc = "Telescope sessions" },
      { "<leader>fc", function() require("telescope.builtin")["colorscheme"]({enable_preview = false}) end, desc = "Colorscheme with preview" },
      { "<leader>fc", function() require("telescope.builtin")["colorscheme"]({enable_preview = false}) end, desc = "Colorscheme with preview" },
      { "<leader>fu", function() require("telescope.builtin")["lsp_document_symbols"]({
        symbols = { "Class", "Function", "Method", "Constructor", "Interface", "Module", "Struct", "Trait", "Field", "Property"},
      }) end, desc = "Goto Symbol (Workspace)" },
      { "<leader>fU", function() require("telescope.builtin")["lsp_dynamic_workspace_symbols"]({
        symbols = { "Class", "Function", "Method", "Constructor", "Interface", "Module", "Struct", "Trait", "Field", "Property"},
      }) end, desc = "Goto Symbol (Workspace)" },
    }
  },


  -- ----------
  -- -路径搜索-
  -- ----------
  {
    "nvim-telescope/telescope-file-browser.nvim",
    lazy = true,
    keys = {
      { "<leader>fF", "<cmd>Telescope file_browser<cr>", desc = "Telescope file browser" },
    }
  },

  -- ------------------------------------
  -- -将vim.ui.select交由telescope来控制-
  -- ------------------------------------
  --
  { 'nvim-telescope/telescope-ui-select.nvim' , lazy = true },
}
