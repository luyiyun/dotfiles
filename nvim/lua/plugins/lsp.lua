return {
  -- ╭──────────────────────────────────────────────────────────────────────────────╮
  -- │                           MASON: lsp servers managers                        │
  -- ╰──────────────────────────────────────────────────────────────────────────────╯
  {
    "williamboman/mason.nvim",  -- mason官方不推荐进行lazy loading
    -- build = ":MasonUpdate",
    opts = {
      -- keymaps = {
      --   toggle_package_expand   = "o", -- 展开
      --   install_package         = "i", -- 安装
      --   update_package          = "u", -- 更新
      --   update_all_packages     = "U", -- 更新所有
      --   check_package_version   = "c", -- 检查版本
      --   check_outdated_packages = "C", -- 检查所有
      --   uninstall_package       = "X", -- 删除
      --   cancel_installation     = "<C-c>", -- 取消安装
      --   apply_language_filter   = "<C-f>", -- 筛选
      -- },
      -- max_concurrent_installers = 10,
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    }
  },

  -- ╭──────────────────────────────────────────────────────────────────────────────╮
  -- │                     LSP/CMP: 代码提示/ 补全配置/ UI增强                      │
  -- ╰──────────────────────────────────────────────────────────────────────────────╯
  -- nvim自带lsp功能，即其可以作为language server的客户端。
  -- {
  --   "neovim/nvim-lspconfig",
  --   event = { "BufReadPre", "BufNewFile" },
  --   dependencies = {
  --     "williamboman/mason.nvim",
  --     -- 用来链接mason和lspconfig之间的gap，比如名称的区别
  --     "williamboman/mason-lspconfig.nvim",
  --
  --     -- "nvimdev/lspsaga.nvim",
  --     -- { "folke/neoconf.nvim", cmd = "Neoconf", config = true },
  --     -- NOTE: 为了应用neodev，首先需要将mason,mason-lspconfig,nvim-lspconfig都升级到
  --     -- NOTE: 最新版本，然后使用新的lua的LSP名称（lua_ls，而非sumneko_lua）
  --     -- { "folke/neodev.nvim", opts = {}},
  --     -- "mason.nvim",  -- 也可以只是名字，但需要保证这在其他地方已经提前定义过了
  --     -- {
  --     --   "hrsh7th/cmp-nvim-lsp",
  --     --   cond = function()
  --     --     return require("lazyvim.util").has("nvim-cmp")
  --     --   end,
  --     -- },
  --   },
  --   config = function()
  --     -- 这是一个对于mason plugin的补充，用来更好的让mason和lspconfig两个插件共同工作
  --     -- 三个插件的启动顺序必须要保证：mason->mason-lspconfig->使用lspconfig来设置lsp server
  --     mslp = require("mason-lspconfig")
  --     mslp.setup({
  --       automatic_installation = true, -- 自动安装LSP服务端
  --       -- 要安装的LSP服务:
  --       -- https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
  --       ensure_installed       = {
  --         "lua_ls",
  --         -- "clangd",
  --         "pyright",
  --         "yamlls",
  --       }
  --     })
  --
  --   end,
  -- },                 -- lspconfig 用于配置nvim的lsp功能，lsp需要自己安装

  -- { "hrsh7th/cmp-nvim-lsp" },                  -- 使cmp可以利用到lsp中的source
  -- { "hrsh7th/cmp-vsnip" },                     -- 使cmp可以利用到vsnip中的source
  -- { "hrsh7th/cmp-buffer" },                    -- { name = 'buffer' },
  -- { "hrsh7th/cmp-path" },                      -- { name = 'path' }
  -- { "hrsh7th/cmp-cmdline" },                   -- { name = 'cmdline' }
  -- { "hrsh7th/nvim-cmp" },                      -- 补全引擎，nvim虽然能够作为客户端和LSP通讯，但是其没有自动补全（可以手动补全）
  -- { "hrsh7th/vim-vsnip" },                     -- vim-vsnip 插件，提供snippets
  -- use({ "hrsh7th/cmp-nvim-lsp-signature-help" })   -- { name = 'nvim_lsp_signature_help' }
  -- use({ "hrsh7th/cmp-nvim-lua" })                  -- { name = 'nvim_lua' }
  -- use({ "jose-elias-alvarez/null-ls.nvim" })       -- 多语言代码检查工具, 功能类似 ESLint
  -- { "rafamadriz/friendly-snippets" }          -- 常见编程语言 snippets

}
