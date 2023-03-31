-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │  侧边栏目录树                                                                │
-- │  docs: https://github.com/nvim-treesitter/nvim-treesitter                    │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
local treesitterConfigs = loadModule("nvim-treesitter.configs", "plugin-configs")
local wk = loadModule("which-key", "plugin-configs")

wk.register({
    ["<leader>T"] = {
        name = "Treesitter",
        i = {
          "<cmd>TSInstallInfo<CR>",
          "treesitter install info[treesitter]"
        },
        c = {
          "<cmd>TSConfigInfo<CR>",
          "treesitter config info[treesitter]"
        },
        m = {
          "<cmd>TSModuleInfo<CR>",
          "treesitter module info[treesitter]"
        },
    }
})

treesitterConfigs.setup({
  sync_install     = true,
  auto_install     = true,
  ensure_installed = {"lua", "vim", "json", "markdown", "python"},  -- { "json", "lua", "markdown", "vim", "yaml", "cpp", "cuda", "c", "python"},
  keymaps          = {
      init_selection    = '<CR>',
      node_incremental  = '<CR>',
      node_decremental  = '<BS>',
      scope_incremental = '<TAB>',
  },

  -- ╭──────────────────────────────────────────────────────────────────────────────╮
  -- │                                   语法高亮                                   │
  -- ╰──────────────────────────────────────────────────────────────────────────────╯
  highlight        = {
    enable                            = true,
    additional_vim_regex_highlighting = false
  },

  -- ╭──────────────────────────────────────────────────────────────────────────────╮
  -- │                             使用 treesitter 缩进                             │
  -- ╰──────────────────────────────────────────────────────────────────────────────╯
  indent           = {
    enable = false,  -- NOTE: 这个缩进效果不好
  },

  -- ╭──────────────────────────────────────────────────────────────────────────────╮
  -- │  识别语法注释:                                                               │
  -- │  https://github.com/JoosepAlviste/nvim-ts-context-commentstring              │
  -- ╰──────────────────────────────────────────────────────────────────────────────╯
  -- context_commentstring = {
  --   enable = true,
  --   enable_autocmd = false,
  -- },

  -- ╭──────────────────────────────────────────────────────────────────────────────╮
  -- │        不同括号不同颜色显示: https://github.com/p00f/nvim-ts-rainbow         │
  -- ╰──────────────────────────────────────────────────────────────────────────────╯
  rainbow          = {
    enable         = true,
    disable        = {}, -- 对某些语言禁用该功能
    extended_mode  = true,
    max_file_lines = nil,
    -- colors         = {},
    -- termcolors     = {}
  },
  -- textsubjects     = {
  --   -- ╭──────────────────────────────────────────────────────────────────────────────╮
  --   -- │       选中增强: https://github.com/RRethy/nvim-treesitter-textsubjects       │
  --   -- ╰──────────────────────────────────────────────────────────────────────────────╯
  --   enable         = true,
  --   prev_selection = keys.textsubjects_prev_selection,
  --   keymaps        = keys.textsubjects_keymaps,
  -- },
  -- autotag          = {
  --   -- ╭──────────────────────────────────────────────────────────────────────────────╮
  --   -- │          xml标签自动闭合: https://github.com/windwp/nvim-ts-autotag          │
  --   -- ╰──────────────────────────────────────────────────────────────────────────────╯
  --   enable = true
  -- },
  -- textobjects      = {
  --   -- ╭──────────────────────────────────────────────────────────────────────────────╮
  --   -- │                               众多功能集合体:                                │
  --   -- │        https://github.com/nvim-treesitter/nvim-treesitter-textobjects        │
  --   -- ╰──────────────────────────────────────────────────────────────────────────────╯
  --   swap = {
  --     -- 调换函数参数的位置
  --     enable        = true,
  --     swap_next     = keys.textobjects_swap_next,
  --     swap_previous = keys.textobjects_swap_prev,
  --   },
  --   move = {
  --     -- 快速移动
  --     enable              = true,
  --     set_jumps           = true,
  --     goto_next_start     = keys.textobjects_move_goto_next_start,
  --     goto_next_end       = keys.textobjects_move_goto_next_end,
  --     goto_previous_start = keys.textobjects_goto_previous_start,
  --     goto_previous_end   = keys.textobjects_goto_previous_end,
  --   },
  --   select = {
  --     -- 快速选中: https://github.com/nvim-treesitter/nvim-treesitter-textobjects#built-in-textobjects
  --     enable                         = true,
  --     lookahead                      = true,
  --     include_surrounding_whitespace = false, -- BUG:not working
  --     keymaps                        = keys.textobjects_select_keymaps,
  --   },
  -- }
});






-- textsubjects_prev_selection = ",",
-- textsubjects_keymaps = {
--   ['0'] = 'textsubjects-smart',
--   ['='] = 'textsubjects-container-outer',
--   ['-'] = 'textsubjects-container-inner',
-- },
-- textobjects_swap_next = {
--   ["<leader>An"] = "@parameter.inner",
-- },
-- textobjects_swap_prev = {
--   ["<leader>An"] = "@parameter.inner",
-- },
-- textobjects_move_goto_next_start = {
--   ["]m"] = "@function.outer",
--   ["]c"] = "@class.outer",
-- },
-- textobjects_move_goto_next_end = {
--   ["]M"] = "@function.outer",
--   ["]C"] = "@class.outer",
-- },
-- textobjects_goto_previous_start = {
--   ["[m"] = "@function.outer",
--   ["[c"] = "@class.outer",
-- },
-- textobjects_goto_previous_end = {
--   ["[M"] = "@function.outer",
--   ["[C"] = "@class.outer",
-- },
-- textobjects_select_keymaps = {
--   ["sa"] = { query = "@attribute.inner", desc = "attribute inner[textobjects]" },
--   ["sA"] = { query = "@attribute.outer", desc = "attribute outer[textobjects]" },
--   ["sb"] = { query = "@block.inner", desc = "block inner[textobjects]" },
--   ["sB"] = { query = "@block.outer", desc = "block outer[textobjects]" },
--   ["sc"] = { query = "@class.inner", desc = "class inner[textobjects]" },
--   ["sC"] = { query = "@class.outer", desc = "class outer[textobjects]" },
--   ["sf"] = { query = "@function.inner", desc = "function inner[textobjects]" },
--   ["sF"] = { query = "@function.outer", desc = "function outer[textobjects]" },
--   ["si"] = { query = "@conditional.inner", desc = "conditional inner[textobjects]" },
--   ["sI"] = { query = "@conditional.outer", desc = "conditional outer[textobjects]" },
--   ["sl"] = { query = "@loop.inner", desc = "loop(for/while) inner[textobjects]" },
--   ["sL"] = { query = "@loop.outer", desc = "loop(for/while) outer[textobjects]" },
--   ["sp"] = { query = "@parameter.inner", desc = "arguments inner[textobjects]" },
--   ["sP"] = { query = "@parameter.outer", desc = "arguments outer[textobjects]" },
-- }
