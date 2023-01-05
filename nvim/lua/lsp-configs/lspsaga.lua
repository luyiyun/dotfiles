-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │  UI 美化(代码提示|代码诊断)                                                  │
-- │  docs: https://github.com/glepnir/lspsaga.nvim                               │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
local lspsaga = loadModule("lspsaga", "lsp");
local wk = loadModule("which-key", "plugin-configs");


-- wk.register({
--     ["g"] = {
--         name = "Goto ...",
--         h = {"<cmd>Lspsaga hover_doc<CR>", "Lspsaga hover[lspsaga]"},
--         d = {"<cmd>Lspsaga lsp_finder<CR>", "Lspsaga finder[lspsaga]"},
--         D = {"<cmd>Lspsaga peek_definition<CR>", "Lspsaga finder (peek definition)[lspsaga]"},
--     },
--     [''] = {
--         name = "Diagnosis navigator",
--         ["[["] = {"<cmd>Lspsaga diagnostic_jump_prev<cr>", "previous diagnosis[lspsaga]"},
--         ["]]"] = {"<cmd>Lspsaga diagnostic_jump_next<cr>", "next diagnosis[lspsaga]"},
--         ["[e"] = {
--             function()
--                 require("lspsaga.diagnostic").goto_prev({
--                     severity = vim.diagnostic.severity.ERROR
--                 })
--             end, "previous error[lspsaga]"
--         },
--         ["]e"] = {
--             function()
--                 require("lspsaga.diagnostic").goto_next({
--                     severity = vim.diagnostic.severity.ERROR
--                 })
--             end, "next error[lspsaga]"
--         }
--     },
--     ['<leader>d'] = {
--         name = "Diagnosis show",
--         l = {"<cmd>Lspsaga show_line_diagnostics<CR>", "Show line diagnostics[lspsaga]"},
--         c = {"<cmd>Lspsaga show_cursor_diagnostics<CR>", "Show cursor diagnostics[lspsaga]"},
--         f = {"<cmd>Lspsaga code_action<CR>", "code action quickFix[lspsaga]"},
--         o = {"<cmd>LSoutlineToggle<CR>", "show symbols[lspsaga]"},
--         r = {"<cmd>Lspsaga rename<CR>", "edit symbol name[lspsaga]"},
--     },
-- })
--
-- wk.register({
--     ["<leader>rn"] = {"<cmd>Lspsaga rename<CR>", "edit symbol name[lsp]"},
-- }, {mode = "v"})

-- wk.register({
-- ["<leader>te"] = {
--   [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]],
--   "open float Terminal[lsp]"
-- }
-- }, { mode = "t" })


return {
  onstart = function()
    lspsaga.init_lsp_saga({
      -- Options with default value
      -- "single" | "double" | "rounded" | "bold" | "plus"
      border_style = "single",
      --the range of 0 for fully opaque window (disabled) to 100 for fully
      --transparent background. Values between 0-30 are typically most useful.
      saga_winblend = 15,
      -- when cursor in saga window you config these to move
      move_in_saga = {
          prev = '<C-k>', -- k 选中上一项
          next = '<C-j>' -- j 选中下一项
      },
      -- Error, Warn, Info, Hint
      -- { " ", " ", " ", "ﴞ " },
      -- use emoji like
      -- { "🙀", "😿", "😾", "😺" }
      -- or
      -- { "😡", "😥", "😤", "😐" }
      -- and diagnostic_header can be a function type
      -- must return a string and when diagnostic_header
      -- is function type it will have a param `entry`
      -- entry is a table type has these filed
      -- { bufnr, code, col, end_col, end_lnum, lnum, message, severity, source }
      diagnostic_header = { "🙀", "😿", "😾", "😺" },
      -- preview lines above of lsp_finder
      preview_lines_above = 0,
      -- preview lines of lsp_finder and definition preview
      max_preview_lines = 10,
      -- use emoji lightbulb in default
      code_action_icon = "💡",
      -- if true can press number to execute the codeaction in codeaction window
      code_action_num_shortcut = true,
      -- same as nvim-lightbulb but async
      code_action_lightbulb = {
          enable = true,
          enable_in_insert = true,
          cache_code_action = true,
          sign = true,
          update_time = 150,
          sign_priority = 20,
          virtual_text = true,
      },
      -- finder icons
      finder_icons = {
        def = '  ',
        ref = '諭 ',
        link = '  ',
      },
      -- finder do lsp request timeout
      -- if your project is big enough or your server very slow
      -- you may need to increase this value
      finder_request_timeout = 1500,
      finder_action_keys = {
          open        = "o", -- 进入当前行所在位置
          vsplit      = "v", -- 左右分屏
          split       = "s", -- 上下分屏
          tabe        = "t",
          quit        = "<ESC>", -- 退出finder
          scroll_down = "<C-u>", -- 向上滚动
          scroll_up   = "<C-d>", -- 向下滚动
      },
      code_action_keys = {
          quit = "<ESC>", -- 退出修复
          exec = "<CR>", -- 执行修复
      },
      definition_action_keys = {
          edit = 'o',
          vsplit = 'v',
          split = 's',
          tabe = 't',
          quit = 'q',
      },
      rename_action_quit = "ESC",
      rename_in_select = true,
      -- show symbols in winbar must nightly
      -- in_custom mean use lspsaga api to get symbols
      -- and set it to your custom winbar or some winbar plugins.
      -- if in_cusomt = true you must set in_enable to false
      symbol_in_winbar = {
          in_custom = false,
          enable = true,
          separator = ' ',
          show_file = true,
          -- define how to customize filename, eg: %:., %
          -- if not set, use default value `%:t`
          -- more information see `vim.fn.expand` or `expand`
          -- ## only valid after set `show_file = true`
          file_formatter = "",
          click_support = false,
      },
      -- show outline
      show_outline = {
        win_position = 'right',
        --set special filetype win that outline window split.like NvimTree neotree
        -- defx, db_ui
        win_with = '',
        win_width = 30,
        auto_enter = true,
        auto_preview = true,
        virt_text = '┃',
        jump_key = 'o',
        -- auto refresh when change buffer
        auto_refresh = true,
      },
      -- custom lsp kind
      -- usage { Field = 'color code'} or {Field = {your icon, your color code}}
      custom_kind = {},
      -- if you don't use nvim-lspconfig you must pass your server name and
      -- the related filetypes into this table
      -- like server_filetype_map = { metals = { "sbt", "scala" } }
      server_filetype_map = {},
    })
  end
}
