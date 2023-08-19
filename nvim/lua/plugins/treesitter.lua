-- --------------------------------------------------
-- -Treesitter相关（语法解析工具，让编辑器理解代码）-
-- --------------------------------------------------
return {
  {
    "nvim-treesitter/nvim-treesitter",
    -- version = false, -- last release is way too old and doesn't work on Windows
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    -- treesitter的一个模块，其可以为嵌套的括号显示不同的颜色
    dependencies = "p00f/nvim-ts-rainbow",
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
    config = function(_, opts) require("nvim-treesitter.configs").setup(opts) end
  },
}
