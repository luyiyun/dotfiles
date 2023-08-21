return {
  -- --------
  -- -启动页-
  -- --------
  -- {
  --   'glepnir/dashboard-nvim',
  --   event = "VimEnter",
  --   config = function()
  --     local db = require('dashboard')
  --     local telescope = require("telescope.builtin")
  --     -- macos
  --     -- db.preview_command = 'cat | lolcat -F 0.3'
  --     -- linux
  --     -- db.preview_command = 'ueberzug'
  --     --
  --     -- db.preview_file_path = home .. '/.config/nvim/static/neovim.cat'
  --     -- db.preview_file_height = 11
  --     -- db.preview_file_width = 70
  --     db.custom_center = {
  --         {icon = '  ',
  --         desc = 'Recently latest session                 ',
  --         shortcut = 'SPC s l',
  --         action ='SessionLoad'},
  --         {icon = '  ',
  --         desc = 'Recently opened files                   ',
  --         action =  telescope.oldfiles,
  --         shortcut = 'SPC f o'},
  --         {icon = '  ',
  --         desc = 'Find File                               ',
  --         action = telescope.find_files,
  --         shortcut = 'SPC f f'},
  --         {icon = '  ',
  --         desc = 'File Browser                            ',
  --         action =  'Telescope file_browser',
  --         shortcut = 'SPC f d'},
  --         {icon = '  ',
  --         desc = 'Find  word                              ',
  --         action =  telescope.live_grep,
  --         shortcut = 'SPC f g'},
  --         -- {icon = '  ',
  --         -- desc = 'Open Personal dotfiles(not implemented)                  ',
  --         -- action = 'Telescope find_files ' .. vim.fn.stdpath("config"),
  --         -- shortcut = 'SPC f c'},
  --     }
  --   end,
  --   dependencies = {{"nvim-tree/nvim-web-devicons"}}
  -- },
  {
    'goolord/alpha-nvim',
    event = "VimEnter",
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      -- custom display
      -- Set header
      local dashboard = require("alpha.themes.dashboard")
      dashboard.section.header.val = {
        "                                      ",
        " ██████╗  ██████╗ ███╗   ██╗ ██████╗  ",
        " ██╔══██╗██╔═══██╗████╗  ██║██╔════╝  ",
        " ██████╔╝██║   ██║██╔██╗ ██║██║  ███╗ ",
        " ██╔══██╗██║   ██║██║╚██╗██║██║   ██║ ",
        " ██║  ██║╚██████╔╝██║ ╚████║╚██████╔╝ ",
        " ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝  ",
        "                                      ",
      }
      -- Set menu
      dashboard.section.buttons.val = {
        dashboard.button("e", "  > New file", ":ene <BAR> startinsert <CR>"),
        dashboard.button("SPC f f", "  > Find file"),
        dashboard.button("SPC f o", "  > Recent"),
        dashboard.button("SPC f s", "  > Sessions"),
        dashboard.button("CRLT q", "  > Quit NVIM"),
      }
      -- Set footer
      local fortune = require("alpha.fortune")
      dashboard.section.footer.val = fortune()

      -- require'alpha'.setup(require'alpha.themes.startify'.config)  -- vim-startify theme
      require 'alpha'.setup(require 'alpha.themes.dashboard'.config) -- dashboard theme

    end
  }
}
