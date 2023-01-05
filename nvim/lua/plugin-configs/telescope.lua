local wk = loadModule("which-key", "plugin-configs")
local telescope = loadModule("telescope", "plugin-configs")
local actions = loadModule("telescope.actions", "plugin-configs")
local builtin = loadModule("telescope.builtin", "plugin-configs")

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
local imap = {
  ["<C-j>"] = actions.move_selection_next,
  ["<C-k>"] = actions.move_selection_previous,
  ["<C-q>"] = actions.close,
}
local nmap = {
  ["<C-c>"] = false,
}

telescope.setup({
  defaults = {
    mappings = {
      i = imap,
      n = nmap,
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
      -- mappings = {},
    },
  }
})

telescope.load_extension("fzf")
telescope.load_extension("file_browser")
telescope.load_extension("persisted")
