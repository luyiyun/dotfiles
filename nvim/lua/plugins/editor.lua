-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │                                  编辑增强                                    │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
return {
  -- ------
  -- -注释-
  -- ------
  {
    'numToStr/Comment.nvim',
    event = "VeryLazy",
    config = true,
  },
  -- --------------------
  -- -自动输入匹配的括号-
  -- --------------------
  {
    "windwp/nvim-autopairs",
    event = "VeryLazy",
    opts = { map_cr = true },
  },
  -- ----------
  -- -缩进显示-
  -- ----------
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "VeryLazy",
    opts = {
      -- NOTE: 开启后会导致一些内容泄露到行号的左侧
      show_current_context = false,
      show_current_context_start = false,
      show_end_of_line = false,
    },
  },
  -- ----------
  -- -智能缩进-
  -- ----------
  -- {
  --   'nmac427/guess-indent.nvim',
  --   config = function() require('guess-indent').setup {} end,
  -- },

  -- ------------------
  -- -两侧字符快速修改-
  -- ------------------
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = true
  },
  -- -- ----------------
  -- -- -TODO及其他标识-
  -- -- ----------------
  -- {
  --   "folke/todo-comments.nvim",
  --   dependencies = "nvim-lua/plenary.nvim",
  --   event = "VeryLazy",
  --   config = true,
  --   keys = {
  --     {"]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment"},
  --     {"[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment"},
  --     {"<leader>ft", "<cmd>TodoTelescope<cr>", desc = "Search through all project todos with Telescope"},
  --   }
  -- },
  -- -- ------------------
  -- -- -高亮光标所在对象-
  -- -- ------------------
  -- {"RRethy/vim-illuminate", event = "VeryLazy"},
  -- -- ------------------
  -- -- -自动删除行尾空格-
  -- -- ------------------
  {
    "cappyzawa/trim.nvim",
    event = "VeryLazy",
    config = true,
  },
  -- ----------------
  -- -  快速定位    -
  -- ----------------
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "s",  mode = { "n", "x", "o" }, function() require("flash").jump() end,       desc = "Flash" },
      { "st", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      -- { "<leader>r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      -- { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      -- { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },
  -- ----------------
  -- -  光滑地滑动  -
  -- ----------------
  {
    "karb94/neoscroll.nvim",
    event = "VeryLazy",
    opts = {},
  },
  {
    "rainbowhxch/accelerated-jk.nvim",
    event = "VeryLazy",
    keys = {
      { "j", "<Plug>(accelerated_jk_j)" },
      { "k", "<Plug>(accelerated_jk_k)" },
      -- {"gj", "<Plug>(accelerated_jk_gj)"},
      -- {"gk", "<Plug>(accelerated_jk_gk)"},
    },
    config = true
  },
  -- --------------------
  -- -  输入法自动切换  -
  -- --------------------
  {
    "keaising/im-select.nvim",
    config = function()
      require("im_select").setup({})
    end,
  }
}
