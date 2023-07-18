return {
  -- -----------------------------------------------
  -- UI 增强，将诊断、定义跳转等展示方式进行了增强
  -- -----------------------------------------------
  {
    "nvimdev/lspsaga.nvim",
    dependencies = {
        'nvim-treesitter/nvim-treesitter', -- optional
        'nvim-tree/nvim-web-devicons',     -- optional
    },
    -- event = 'BufRead',
    -- config = function() require('plugin-configs.lspsaga') end,
    keys = {
      {"gd", "<cmd>Lspsaga peek_definition<CR>", desc = "Lspsaga go to definition[lspsaga]"},
      {"gf", "<cmd>Lspsaga finder<CR>", desc = "Lspsaga finder[lspsaga]"},
      {"K", "<cmd>Lspsaga hover_doc<CR>", desc = "Lspsaga hover[lspsaga]"},
      -- {"[d", "<cmd>Lspsaga diagnostic_jump_prev<cr>", desc = "previous diagnosis[lspsaga]"},
      -- {"[e", function() require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR }) end, desc = "previous error[lspsaga]"},
      -- {"]d", "<cmd>Lspsaga diagnostic_jump_next<cr>", desc = "next diagnosis[lspsaga]"},
      -- {"]e", function() require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR }) end, desc = "next error[lspsaga]" },
      -- {"<leader>dl", "<cmd>Lspsaga show_line_diagnostics<CR>", desc = "Show line diagnostics[lspsaga]"},
      -- {"<leader>dc", "<cmd>Lspsaga show_cursor_diagnostics<CR>", desc = "Show cursor diagnostics[lspsaga]"},
      -- {"<leader>da", "<cmd>Lspsaga code_action<CR>", desc = "code action quickFix[lspsaga]"},
      -- {"<leader>ds", "<cmd>LSoutlineToggle<CR>", desc = "show symbols[]"},
      -- {"<leader>dr", "<cmd>Lspsaga rename<CR>", desc = "edit symbol name[lspsaga]"},
    },
    opts = {
      finder = {
        keys = {
          toggle_or_open = "o",
          split = "s",
          vsplit = "v",
          close = "<ESC>",
        }
      },
      definition = {
        keys = {
          close = "<ESC>"
        },

      },
      -- border_style = "single",
      -- saga_winblend = 15,
      -- move_in_saga = {
      --     prev = '<C-k>', -- k 选中上一项
      --     next = '<C-j>' -- j 选中下一项
      -- },
      -- diagnostic_header = { "🙀", "😿", "😾", "😺" },
      -- preview_lines_above = 0,
      -- max_preview_lines = 10,
      -- code_action_icon = "💡",
      -- code_action_num_shortcut = true,
      -- code_action_lightbulb = {
      --     enable = true,
      --     enable_in_insert = true,
      --     cache_code_action = true,
      --     sign = true,
      --     update_time = 150,
      --     sign_priority = 20,
      --     virtual_text = true,
      -- },
      -- finder_icons = {def = '  ', ref = '諭 ', link = '  '},
      -- finder_request_timeout = 1500,
      -- finder_action_keys = {
      --     open        = "<C-o>", -- 进入当前行所在位置
      --     vsplit      = "<C-v>", -- 左右分屏
      --     split       = "<C-s>", -- 上下分屏
      --     tabe        = "<C-t>",
      --     quit        = {"<ESC>", "<C-q>"}, -- 退出finder
      --     scroll_down = "<C-u>", -- 向上滚动
      --     scroll_up   = "<C-d>", -- 向下滚动
      -- },
      -- code_action_keys = {
      --     quit = {"<ESC>", "<C-q>"}, -- 退出修复
      --     exec = "<CR>", -- 执行修复
      -- },
      -- definition_action_keys = {
      --     edit = '<C-o>',
      --     vsplit = '<C-v>',
      --     split = '<C-s>',
      --     tabe = '<C-t>',
      --     quit = {'<C-q>', '<ESC>'},
      -- },
      -- rename_action_quit = "ESC",
      -- rename_in_select = true,
      -- symbol_in_winbar = {
      --     in_custom = false,
      --     enable = true,
      --     separator = ' ',
      --     show_file = true,
      --     file_formatter = "",
      --     click_support = false,
      -- },
      -- show_outline = {
      --   win_position = 'right',
      --   win_with = '',
      --   win_width = 30,
      --   auto_enter = true,
      --   auto_preview = true,
      --   virt_text = '┃',
      --   jump_key = 'o',
      --   auto_refresh = true,
      -- },
      -- custom_kind = {},
      -- server_filetype_map = {},
    }
  }
}
