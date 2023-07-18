-- --------------------------------------------------
-- -Treesitter相关（语法解析工具，让编辑器理解代码）-
-- --------------------------------------------------
return {
  {
    "nvim-treesitter/nvim-treesitter",
    -- version = false, -- last release is way too old and doesn't work on Windows
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    -- dependencies = {
    --   {
    --     "nvim-treesitter/nvim-treesitter-textobjects",
    --     init = function()
    --       -- disable rtp plugin, as we only need its queries for mini.ai
    --       -- In case other textobject modules are enabled, we will load them
    --       -- once nvim-treesitter is loaded
    --       require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
    --       load_textobjects = true
    --     end,
    --   },
    -- },
    -- build = function()
    --   local installer = loadModule("nvim-treesitter.install", "plugin-configs")
    --   installer.prefer_git = false
    --   installer.compilers = {"gcc", "clang"}
    --   local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
    --   ts_update()
    -- end,
    -- config = function() require("plugin-configs.nvim-treesitter") end,
    cmd = { "TSUpdateSync" },
    opts = {
      highlight = { enable = true },
      indent = { enable = false },
      ensure_installed = {
        "bash",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "vim",
        "yaml",
      },
      -- incremental_selection = {
      --   enable = true,
      --   keymaps = {
      --     init_selection = "<C-space>",
      --     node_incremental = "<C-space>",
      --     scope_incremental = false,
      --     node_decremental = "<bs>",
      --   },
      -- },
      rainbow = {
        enable         = true,
        disable        = {}, -- 对某些语言禁用该功能
        extended_mode  = true,
        max_file_lines = nil,
        -- colors         = {},
        -- termcolors     = {}
      }
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end
  },
  -- treesitter的一个模块，其可以为嵌套的括号显示不同的颜色
  {
    "p00f/nvim-ts-rainbow",
    dependencies = "nvim-treesitter/nvim-treesitter",
  },

}
