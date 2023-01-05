-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │         #    # ###### #   #       #    # ###### #    # #    #  ####          │
-- │         #   #  #       # #        ##  ## #      ##   # #    # #              │
-- │         ####   #####    #   ##### # ## # #####  # #  # #    #  ####          │
-- │         #  #   #        #         #    # #      #  # # #    #      #         │
-- │         #   #  #        #         #    # #      #   ## #    # #    #         │
-- │         #    # ######   #         #    # ###### #    #  ####   ####          │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
-- sfsfsfs
--------------------------------------
-- Normal 菜单
--------------------------------------
local create_noremal_menus = function(wk)
  wk.register({
    ["<leader>"] = { nil, "show key menus" },
    -- ["x"]        = { nil, "delete" },

    -- -- comment
    -- ["<C-\\>"] = { nil, "toggle comment[kommentary]" },
    -- ["<C-b>"]  = { nil, "Back" },
    -- ["<C-d>"]  = { nil, "scroll down" },

    -- -- splitjoin
    -- ["gJ"] = { nil, "join line[splitjoin]" },
    -- ["gS"] = { nil, "split line[splitjoin]" },

    -- -- selection
    -- ["vs"] = { name = "+Selection" },

    -- -- fold
    -- ["z"] = { name = "+Fold" },

    -- -- arguments
    -- ["<leader>A"] = {
    --   name = "+Arguments",
    --   p = { nil, "swap arguments previous[textobjects]" };
    --   n = { nil, "swap arguments next[textobjects]" };
    -- },

    -- -- buffers
    -- ["<leader>b"]  = {
    --   name = "+Buffer",
    -- },
    -- ["<leader>b1"] = {
    --   nil,
    --   "first Buffer"
    -- },
    -- ["<leader>b0"] = {
    --   nil,
    --   "last Buffer"
    -- },
    -- ["<leader>bb"] = {
    --   nil,
    --   "show all buffers"
    -- },
    -- ["<leader>bs"] = {
    --   nil,
    --   "search buffers"
    -- },
    -- ["<leader>bd"] = {
    --   nil,
    --   "close current buffer"
    -- },
    -- ["<leader>bl"] = {
    --   nil,
    --   "move buffer to right"
    -- },
    -- ["<leader>bj"] = {
    --   nil,
    --   "move buffer to bottom"
    -- },
    -- ["<leader>bn"] = {
    --   nil, -- H
    --   "next buffer"
    -- },
    -- ["<leader>bp"] = {
    --   nil, -- L
    --   "previous buffer"
    -- },
    -- ["<leader>bD"] = {
    --   nil,
    --   "close other buffers"
    -- },
    -- ["<leader>bY"] = {
    --   nil,
    --   "copy buffer to clipboard"
    -- },
    -- ["<leader>bP"] = {
    --   function()
    --     vim.cmd [[
    --       :%delete _
    --       :put+
    --     ]]
    --   end,
    --   "paste clipboard to buffer"
    -- },

    -- -- comments/code_action
    -- ["<leader>c"] = {
    --   name = "+Comment/CodeAction",
    -- },

    -- -- debugger
    -- ["<leader>d"] = {
    --   name = "+Debugger",
    -- },

    -- -- errors
    -- ["<leader>e"] = {
    --   name = "+Error",
    -- },

    -- -- find/file
    -- ["<leader>f"] = {
    --   name = "+File/Find",
    --   R = {
    --     -- "<cmd>RnvimrToggle<CR>",
    --     "<cmd>Vifm<CR>",
    --     "open with ranger(C-n)[rnvimr]"
    --   },
    --   o = {
    --     nil,
    --     "open file with system explorer"
    --   },
    --   L = {
    --     nil,
    --     "open file with system explorer"
    --   },
    --   s = {
    --     nil,
    --     "save current buffer"
    --   }
    -- },

    -- -- git
    -- ["<leader>g"] = {
    --   name = "+Git",
    --   i = { nil, "git init" },
    -- },

    -- -- helps
    -- ["<leader>h"] = {
    --   name = "+Help",
    --   d = { nil, "open neovim documentation" },
    --   D = { nil, "open which-key documentation" },
    --   i = { nil, "report neovim issue" },
    -- },

    -- ["<leader>i"] = {
    --   name = "+Insert",
    --   i = { nil, "Insert Image URL" },
    --   l = { nil, "insert console.log" }
    -- },

    -- -- jump/join/split
    -- ["<leader>j"] = {
    --   name = "+Jump",
    --   ["t"] = { name = "+TODO" }
    -- },

    -- -- List
    -- ["<leader>l"] = {
    --   name = "+List",
    -- },

    -- -- open
    -- ["<leader>o"] = {
    --   name = "+Open",
    --   V = {
    --     name = "+VIM-links",
    --     ["0"] = { nil, "open vim game" },
    --     ["1"] = { nil, "open vim tips" },
    --     ["2"] = { nil, "open vim cheatsheet" },
    --     ["3"] = { nil, "open w3cschool vimscript" },
    --     ["4"] = { nil, "open vim help docs chinese" },
    --     ["5"] = { nil, "open nvim lua guide" },
    --     ["6"] = { nil, "open typescript to lua playground" },
    --     ["V"] = { nil, "open nvim docs" },
    --   },
    --   b = { nil, "open in google chrome" },
    --   u = { nil, "open url in browser" },
    --   g = { nil, "open with github desktop" }
    -- },

    -- -- project
    -- ["<leader>p"] = {
    --   name = "+Project",
    -- },

    -- -- quit
    -- ["<leader>q"] = {
    --   name = "+Quit",
    --   q = {
    --     nil,
    --     "quit all",
    --   },
    -- },

    -- -- Recent/Replace
    -- ["<leader>r"] = {
    --   name = "+Recent/Replace",
    -- },

    -- -- search/symbol
    -- ["<leader>s"] = {
    --   name = "+Search/Symbol",
    --   s = {
    --     nil,
    --     "save current buffer",
    --   },
    --   h = {
    --     "Highlight world(gd)"
    --   },
    -- },

    -- -- window
    -- ["<leader>w"] = {
    --   name = "+Window",
    --   S = { nil, "split window to bottom" },
    --   V = { nil, "split window to right" },
    --   O = { nil, "close other windows" },
    -- },

    -- -- text
    -- ["<leader>x"] = {
    --   name = "+Text",
    --   o = { nil, "open url in browser" },
    -- },

    -- -- yank/copy
    -- ["<leader>y"] = {
    --   name = "+Yank/Copy",
    --   n = { nil, "Copy current file name" },
    --   p = { nil, "Copy current file absolute path" },
    --   P = { nil, "Copy current file relative path" },
    -- },

    -- -- UI toggle
    -- ["<leader>T"] = {
    --   name = "+UI toggle"
    -- },

    -- -- Bookmarks
    -- ["<leader>B"] = {
    --   name = "+Bookmarks",
    -- },

    -- -- Packer/Plugin
    -- ["<leader>P"] = {
    --   name = "+Packer/treesitter/Mason",
    --   i = {
    --     "<cmd>PackerInstall<CR>",
    --     "install plugins"
    --   },
    --   s = {
    --     "<cmd>PackerSync<CR>",
    --     "plugins sync(upgrade)"
    --   },
    --   S = {
    --     "<cmd>PackerStatus<CR>",
    --     "show all plugins status"
    --   },
    --   c = {
    --     "<cmd>PackerClean<CR>",
    --     "plugins clean"
    --   },
    -- },

    -- -- Markdown
    -- ["<leader>M"] = {
    --   name = "+Markdown",
    -- },

    -- -- treesitter textobjects move
    -- ["["] = {
    --   name = "Move previous",
    --   m = {
    --     nil,
    --     "previous function start[textobjects]"
    --   },
    --   M = {
    --     nil,
    --     "previous function end[textobjects]"
    --   },
    --   c = {
    --     nil,
    --     "previous class start[textobjects]"
    --   },
    --   C = {
    --     nil,
    --     "previous class end[textobjects]"
    --   }
    -- },
    -- ["]"] = {
    --   name = "Move next",
    --   m = {
    --     nil,
    --     "next function start[textobjects]",
    --   },
    --   M = {
    --     nil,
    --     "next function end[textobjects]",
    --   },
    --   c = {
    --     nil,
    --     "next class start[textobjects]"
    --   },
    --   C = {
    --     nil,
    --     "next class end[textobjects]"
    --   }
    -- },

    -- -- refresh
    -- ["<leader>R"] = {
    --   name = "+Refresh",
    --   f = { nil, "refresh file contents" }
    -- }
  });
end

--------------------------------------
-- Visual 菜单
--------------------------------------
local create_visual_menus = function(wk)
  wk.register({
    ["s"] = { name = "+Selection" },
    -- ["<leader>i"] = {
    --   name = "+Insert",
    --   ["l"] = { nil, "insert console.log" },
    -- },
    -- ["<leader>c"] = {
    --   name = "+Comment",
    -- },
    -- ["<leader>a"] = {
    --   name = "+Align",
    -- },
    -- ["<leader>j"] = {
    --   name = "+Jump/join/split",
    -- },
    -- ["<leader>r"] = {
    --   name = "+Replace",
    -- },
    -- ["<leader>s"] = {
    --   name = "+Search/Symbol",
    --   h = { nil, "Highlight world(gd)" },
    -- },
    -- ["<leader>x"] = {
    --   name = "+Text",
    --   K = { nil, "move line up" },
    --   J = { nil, "move line down" },
    -- },
  }, { mode = "v", noremap = false, silent = true })
end

return {
  onstart = function(wk)
    create_noremal_menus(wk);
    create_visual_menus(wk);
  end
};
