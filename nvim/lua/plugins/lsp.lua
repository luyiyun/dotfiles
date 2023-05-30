return {
  -- ╭──────────────────────────────────────────────────────────────────────────────╮
  -- │                     LSP/CMP: 代码提示/ 补全配置/ UI增强                      │
  -- ╰──────────────────────────────────────────────────────────────────────────────╯
  -- nvim自带lsp功能，即其可以作为language server的客户端。
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      -- { "folke/neoconf.nvim", cmd = "Neoconf", config = true },
      -- NOTE: 为了应用neodev，首先需要将mason,mason-lspconfig,nvim-lspconfig都升级到
      -- NOTE: 最新版本，然后使用新的lua的LSP名称（lua_ls，而非sumneko_lua）
      { "folke/neodev.nvim", opts = {}},
      -- "mason.nvim",  -- 也可以只是名字，但需要保证这在其他地方已经提前定义过了
      -- "williamboman/mason-lspconfig.nvim",
      -- {
      --   "hrsh7th/cmp-nvim-lsp",
      --   cond = function()
      --     return require("lazyvim.util").has("nvim-cmp")
      --   end,
      -- },
    },
  },                 -- lspconfig 用于配置nvim的lsp功能，lsp需要自己安装
  { "williamboman/mason.nvim" },               -- LSP/DAP 服务器安装管理工具，这样lsp可以有统一的界面进行安装和管理
  { "williamboman/mason-lspconfig.nvim" },     -- LSP/DAP 服务器安装管理工具，用来链接mason和lspconfig之间的gap，比如名称的区别

  { "hrsh7th/cmp-nvim-lsp" },                  -- 使cmp可以利用到lsp中的source
  { "hrsh7th/cmp-vsnip" },                     -- 使cmp可以利用到vsnip中的source
  { "hrsh7th/cmp-buffer" },                    -- { name = 'buffer' },
  { "hrsh7th/cmp-path" },                      -- { name = 'path' }
  { "hrsh7th/cmp-cmdline" },                   -- { name = 'cmdline' }
  { "hrsh7th/nvim-cmp" },                      -- 补全引擎，nvim虽然能够作为客户端和LSP通讯，但是其没有自动补全（可以手动补全）
  { "hrsh7th/vim-vsnip" },                     -- vim-vsnip 插件，提供snippets
  -- use({ "hrsh7th/cmp-nvim-lsp-signature-help" })   -- { name = 'nvim_lsp_signature_help' }
  -- use({ "hrsh7th/cmp-nvim-lua" })                  -- { name = 'nvim_lua' }
  -- use({ "jose-elias-alvarez/null-ls.nvim" })       -- 多语言代码检查工具, 功能类似 ESLint
  { "rafamadriz/friendly-snippets" },          -- 常见编程语言 snippets

  {
    "glepnir/lspsaga.nvim",
    event = 'BufRead',
    config = function() require('plugin-configs.lspsaga') end
  },                   -- UI 增强，将诊断、定义跳转等展示方式进行了增强
}
