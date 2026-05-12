return {

  -- Enable and configure LuaSnip. In LazyVim you can also enable the extra
  -- with :LazyExtras -> coding.luasnip; this spec just adds the settings
  -- needed for Obsidian-like auto snippets.
  {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
    event = "InsertEnter",
    opts = function(_, opts)
      opts.history = true
      opts.delete_check_events = "TextChanged"
      opts.enable_autosnippets = true
      -- Visual mode: select text, press <Tab>, then type a visual snippet trigger
      -- such as S/U/O/C/K to wrap the selected expression.
      opts.store_selection_keys = "<Tab>"
    end,
    config = function(_, opts)
      local ls = require("luasnip")
      ls.setup(opts)
      require("luasnip.loaders.from_lua").lazy_load({
        paths = vim.fn.stdpath("config") .. "/luasnippets",
      })
      ls.filetype_extend("quarto", { "markdown" })
      ls.filetype_extend("rmd", { "markdown" })
    end,
  },

  {
    "saghen/blink.cmp",
    opts = {
      -- NOTE: 这里我直接使用LazyVim的Extra来开启luasnip
      -- snippets = { preset = "luasnip" },
      --
      -- ================================================
      -- 改变补全时的快捷键
      -- ================================================
      keymap = {
        preset = "enter",
        -- Tab / Shift-Tab 只用于在候选项之间移动
        ["<Tab>"] = { "select_next", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<CR>"] = { "accept", "fallback" },
      },
      completion = {
        list = {
          selection = {
            -- 避免一弹出菜单就自动选择第一项
            preselect = false,
            -- 选择候选时直接替换正文
            auto_insert = true,
          },
        },
      },
      cmdline = {
        enabled = true,

        keymap = {
          -- 不建议直接 inherit，因为正文里的 super-tab/snippet 行为不一定适合命令行
          preset = "cmdline",

          -- 让 : 命令补全也用 Ctrl-j / Ctrl-k
          ["<C-j>"] = { "select_next", "fallback" },
          ["<C-k>"] = { "select_prev", "fallback" },

          -- 可选：Tab 保持命令行补全的默认习惯
          -- ["<Tab>"] = { "show_and_insert_or_accept_single", "select_next" },
          -- ["<S-Tab>"] = { "show_and_insert_or_accept_single", "select_prev" },

          -- NOTE: 这里我们不使用<CR>作为接受，否则会不太顺畅
          -- ["<CR>"] = { "select_and_accept", "fallback" },

          ["<C-e>"] = { "cancel", "fallback" },
        },

        completion = {
          list = {
            selection = {
              preselect = false,
            },
          },
          menu = {
            -- 只在 : 命令模式自动显示，不影响 / 搜索
            auto_show = function()
              return vim.fn.getcmdtype() == ":"
            end,
          },
        },
      },
    },
  },
}
