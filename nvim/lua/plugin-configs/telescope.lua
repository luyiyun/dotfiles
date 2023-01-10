local wk = loadModule("which-key", "plugin-configs")
local telescope = loadModule("telescope", "plugin-configs")
local actions = loadModule("telescope.actions", "plugin-configs")
local builtin = loadModule("telescope.builtin", "plugin-configs")
local fb_actions = loadModule("telescope", "plugin-configs").extensions.file_browser.actions

wk.register({
  ["<leader>f"] = {
    name = "Telescope finder",
    f = {builtin.find_files, "Lists files in your current working directory, respects .gitignore"},
    g = {builtin.live_grep, "Search for a string in your current working directory and get results live as you type, respects .gitignore"},
    b = {builtin.buffers, "Lists open buffers in current neovim instance"},
    h = {builtin.help_tags, "Lists available help tags and opens a new window with the relevant help info on <cr>"},
    o = {builtin.oldfiles, "Lists previously open files"},
    F = {"<cmd>Telescope file_browser<cr>", "telescope file browser"},
    s = {"<cmd>Telescope persisted<cr>", "telescope sessions"}
  }
})

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
      hijack_netrw = true,
      mappings = {
        ['i'] = {
          ["<c-a>"] = fb_actions.create,
          ["<c-r>"] = fb_actions.rename,
          ["<c-c>"] = fb_actions.copy,
          ["<c-m>"] = fb_actions.move,
          ["<c-d>"] = fb_actions.remove,
          ["<c-x>"] = fb_actions.remove,
          ["<c-o>"] = fb_actions.open,
          ["<c-H>"] = fb_actions.goto_parent_dir,
          ["<c-A>"] = fb_actions.select_all,
          ["<c-w>"] = fb_actions.goto_cwd,
          ["<c-s>"] = fb_actions.change_cwd,
          ["<A-c>"] = false,
          ["<c-g>"] = false,
          ["<c-t>"] = false,
          ["<c-h>"] = false,
          ["<c-f>"] = false,
        },
        ["n"] = {
          a = fb_actions.create,
          r = fb_actions.rename,
          c = fb_actions.copy,
          d = fb_actions.remove,
          x = fb_actions.remove,
          o = fb_actions.open,
          ["<cr>"] = fb_actions.open,
          H = fb_actions.goto_parent_dir,
          A = fb_actions.select_all,
          w = fb_actions.goto_cwd,
          s = fb_actions.change_cwd,
        }
      },
    },
  }
})

telescope.load_extension("fzf")
telescope.load_extension("file_browser")
telescope.load_extension("persisted")
