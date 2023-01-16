local wk = loadModule("which-key", "plugin-configs")
local telescope = loadModule("telescope", "plugin-configs")
local actions = loadModule("telescope.actions", "plugin-configs")
local builtin = loadModule("telescope.builtin", "plugin-configs")
-- local fb_actions = telescope.extensions.file_browser.actions

wk.register({
  ["<leader>f"] = {
    name = "Telescope finder",
    f = {builtin.find_files, "Lists files in your current working directory, respects .gitignore"},
    g = {builtin.live_grep, "Search for a string in your current working directory and get results live as you type, respects .gitignore"},
    b = {builtin.buffers, "Lists open buffers in current neovim instance"},
    h = {builtin.help_tags, "Lists available help tags and opens a new window with the relevant help info on <cr>"},
    o = {builtin.oldfiles, "Lists previously open files"},
    F = {"<cmd>Telescope file_browser<cr>", "telescope file browser"},
    -- s = {"<cmd>Telescope persisted<cr>", "telescope sessions"}
    s = {"<cmd>SessionManager load_session<cr>", "telescope sessions"}
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
