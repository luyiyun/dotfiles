return {
  -- {
  --   'nvim-tree/nvim-tree.lua',
  --   dependencies = 'nvim-tree/nvim-web-devicons', -- optional, for file icons
  --   keys = {
  --     -- {"<leader>tt", function ()
  --     --   require("nvim-tree.api").tree.toggle({path = get_root()})
  --     -- end, desc = "toggle file explorer[nvim-tree]"},
  --     -- NOTE:使用下面的sync_root_with_cwd配置也可以达到目的
  --     {"<leader>tt", "<cmd>NvimTreeToggle<CR>", desc = "toggle file explorer[nvim-tree]"},
  --     {"<leader>tf", "<cmd>NvimTreeFocus<CR>", desc = "focus in explorer[nvim-tree]"},
  --     -- {"<leader>tr", "<cmd>NvimTreeRefresh<CR>", desc = "refresh file explorer[nvim-tree]"},
  --     -- {"<leader>to", "<cmd>NvimTreeFindFileToggle<CR>", desc = "toggle file finder explorer[nvim-tree]"}
  --   },
  --   config = function()
  --     vim.g.loaded_netrw       = 1
  --     vim.g.loaded_netrwPlugin = 1
  --     require("nvim-tree").setup({
  --       disable_netrw = true,
  --       hijack_netrw = true,
  --       sync_root_with_cwd = true,  -- 自动根据当前的文件更新root
  --       update_focused_file = {
  --         enable = true,  -- 自动打开文件所在的路径
  --       }
  --     })
  --     -- require("nvim-tree.events").on_file_created(function(file) vim.cmd("edit " .. file.fname) end)
  --   end,
  -- },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    cmd = "Neotree",
    keys = {
      {
        "<leader>tt",
        "<cmd>Neotree toggle<cr>",
        desc = "Explorer NeoTree",
      },
      {
        "<leader>tb",
        "<cmd>Neotree toggle source=buffers<cr>",
        desc = "Explorer NeoTree buffers",
      },
      {
        "<leader>tl",
        "<cmd>Neotree toggle position=current<cr>",
        desc = "Explorer NeoTree within current window",
      },
    },
    opts = {},
    config = function(_, opts)
      -- local icons = require("icons")
      -- vim.tbl_extend("error", {
      --   icon = {
      --     folder_closed = icons.ui.Folder,
      --     folder_open = icons.ui.FolderOpen,
      --     folder_empty = icons.ui.EmptyFolder,
      --   },
      --   git_status = {
      --     symbols = {
      --       added = icons.git.LineAdded,
      --       modified = icons.git.LineModified,
      --       deleted = icons.git.FileDeleted,
      --       rename = icons.git.FileRenamed,
      --       untracked = icons.git.FileUntracked,
      --       ignored = icons.git.FileIgnored,
      --       unstaged = icons.git.FileUnstaged,
      --       staged = icons.git.FileStaged,
      --       conflict = icons.git.Conflict,
      --     }
      --   }
      -- })
      vim.fn.sign_define("DiagnosticSignError", {text = " ", texthl = "DiagnosticSignError"})
      vim.fn.sign_define("DiagnosticSignWarn", {text = " ", texthl = "DiagnosticSignWarn"})
      vim.fn.sign_define("DiagnosticSignInfo", {text = " ", texthl = "DiagnosticSignInfo"})
      vim.fn.sign_define("DiagnosticSignHint", {text = "󰌵", texthl = "DiagnosticSignHint"})

      require("neo-tree").setup(opts)
      -- vim.api.nvim_create_autocmd("TermClose", {
      --   pattern = "*lazygit",
      --   callback = function()
      --     if package.loaded["neo-tree.sources.git_status"] then
      --       require("neo-tree.sources.git_status").refresh()
      --     end
      --   end,
      -- })
    end,
    -- deactivate = function() vim.cmd([[Neotree close]]) end,
    -- init = function()
    --   if vim.fn.argc() == 1 then
    --     local stat = vim.loop.fs_stat(vim.fn.argv(0))
    --     if stat and stat.type == "directory" then
    --       require("neo-tree")
    --     end
    --   end
    -- end,
    -- opts = {
    --   sources = { "filesystem", "buffers", "git_status", "document_symbols" },
    --   open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "Outline" },
    --   filesystem = {
    --     bind_to_cwd = false,
    --     follow_current_file = { enabled = true },
    --     use_libuv_file_watcher = true,
    --   },
    --   window = {
    --     mappings = {
    --       ["<space>"] = "none",
    --       ["S"] = "none", -- 取消open_split的默认设置
    --       ["o"] = "open",
    --       ["s"] = "open_split",
    --       ["v"] = "open_vsplit",
    --     },
    --   },
    --   default_component_configs = {
    --     indent = {
    --       with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
    --       expander_collapsed = "",
    --       expander_expanded = "",
    --       expander_highlight = "NeoTreeExpander",
    --     },
    --   },
    -- },
  }
}
