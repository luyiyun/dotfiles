return {
  -- ╭──────────────────────────────────────────────────────────────────────────────╮
  -- │                           MASON: lsp servers managers                        │
  -- ╰──────────────────────────────────────────────────────────────────────────────╯
  {
    "williamboman/mason.nvim", -- mason官方不推荐进行lazy loading
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

  -- ╭──────────────────────────────────────────────╮
  -- │                     LSP                      │
  -- ╰──────────────────────────────────────────────╯
  -- lsp server提供的功能主要有：代码诊断(diagnostic)、定义跳转(tagfunc\go-defination)、
  --  格式整理(format)、光标悬停(hover)、代码自动补全(complete)、代码修复(reference\implement\code_action)、
  -- 某个LSP server可能只拥有以上功能中的几个，所以其会对应一个capabilities来说明这个问题
  --
  -- 通过对lspconfig进行配置，可以让我们实现以上的功能。
  --    但是这些功能可能存在缺陷（比如补全无法自动实现），或者需要更好看的ui，此时需要额外的一些
  --    插件对其功能进行增强
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim", -- 用来链接mason和lspconfig之间的gap，比如名称的区别
      { "folke/neodev.nvim", opts = {} },  -- 提供用于neovim插件开发的lua api的提示，需要保证在lspconfig之前启动
      -- NOTE: 为了应用neodev，首先需要将mason,mason-lspconfig,nvim-lspconfig都升级到
      -- NOTE: 最新版本，然后使用新的lua的LSP名称（lua_ls，而非sumneko_lua）

      -- "nvimdev/lspsaga.nvim",
      -- { "folke/neoconf.nvim", cmd = "Neoconf", config = true },
      -- "hrsh7th/cmp-nvim-lsp",
      -- {
      --   cond = function() return require("lazyvim.util").has("nvim-cmp") end,
      -- },
    },
    config = function()
      -- mason-lspconfig是对于mason的补充，用来更好的让mason和lspconfig两个插件共同工作
      -- 三个插件的启动顺序必须要保证：mason->mason-lspconfig->使用lspconfig来设置lsp server
      local has_mslp, mslp = pcall(require, "mason-lspconfig")
      if has_mslp then
        mslp.setup({
          automatic_installation = true, -- 自动安装LSP服务端
          -- 要安装的LSP服务:
          -- https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
          ensure_installed       = {
            "lua_ls",
            -- "clangd",
            "pyright",
            "yamlls",
          }
        })
      end

      ------------------------------------------------------------------------------------
      -- (配置) 代码诊断 diagnositc
      ------------------------------------------------------------------------------------
      -- 每当开启一个LSP时，其都会提供这个功能。这部分的配置主要包括两个部分：
      --  1. 如何展示诊断信息；
      --  2. 相关位置的代码跳转
      --
      -- 首先是左侧signcolumn的图标显示
      local signs = {
        { name = "DiagnosticSignError", text = "💢" },
        { name = "DiagnosticSignWarn", text = "😱" },
        { name = "DiagnosticSignHint", text = "🤔" },
        { name = "DiagnosticSignInfo", text = "😐" },
      }
      -- local signs = {
      --   { name = "DiagnosticSignError", text = "" },
      --   { name = "DiagnosticSignWarn",  text = "" },
      --   { name = "DiagnosticSignHint",  text = "" },
      --   { name = "DiagnosticSignInfo",  text = "" },
      -- }
      for _, sign in ipairs(signs) do -- 提示信息图标设置
        vim.fn.sign_define(sign.name, {
          texthl = sign.name,
          text   = sign.text
        })
      end
      vim.diagnostic.config({
        virtual_text     = true, -- 是否显示显示提示文字
        update_in_insert = true,
        underline        = true,
        severity_sort    = true,
        signs            = true, -- 显示图标
      })
      vim.keymap.set('n', 'ge', vim.diagnostic.open_float)
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
      -- vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

      ------------------------------------------------------------------------------------
      -- (配置) 代码补全 complete,
      --        定义跳转 go defination,
      --        悬停 hover,
      --        重命名 rename,
      --        格式化 format,
      --        code action
      ------------------------------------------------------------------------------------
      local has_cmp_nlsp, cmp_nlsp = pcall(require, "cmp_nvim_lsp")
      local on_attach = function(_, bufnr)
        -- complete
        if not has_cmp_nlsp then -- 如果没有cmp，则设置手动版本
          -- Enable completion triggered by <c-x><c-o>
          vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
        end

        -- go defination
        local bufopts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)

        -- hover
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)

        -- rename
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)

        -- format
        vim.keymap.set('n', '<leader>rf', function() vim.lsp.buf.format { async = true } end, bufopts)

        -- code action
        vim.keymap.set('n', '<leader>ra', vim.lsp.buf.code_action, bufopts)
      end

      ------------------------------------------------------------------------------------
      -- 启动LSP
      ------------------------------------------------------------------------------------
      -- 正常启动lsp的方式（使用lspconfig的api）: require("lspconfig").lua_ls.setup({})
      -- 但是，这里我们使用mason-lspconfig的api，其可以保证在需要的时候自动开启lsp server
      if has_mslp then
        mslp.setup_handlers {
          -- The first entry (without a key) will be the default handler
          -- and will be called for each installed server that doesn't have
          -- a dedicated handler.
          function(server_name) -- default handler (optional)
            local lsp_cfg = { on_attach = on_attach }
            if has_cmp_nlsp then
              lsp_cfg["capabilities"] = cmp_nlsp.default_capabilities()
            end

            -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
            if server_name == "lua_ls" then
              lsp_cfg["settings"] = {
                Lua = {
                  runtime = { version = 'LuaJIT' },
                  diagnostics = { globals = { "vim" } },
                  completion = { enable = true, callSnippet = "Replace" },
                  telemetry = { enable = false },
                  workspase = {
                    library = vim.api.nvim_get_runtime_file("", true),
                    checkThirdParty = false
                  }
                }
              }
              -- lsp_cfg["on_init"] = function(client)
              --   local path = client.workspace_folders[1].name
              --   if not vim.loop.fs_stat(path .. '/.luarc.json') and not vim.loop.fs_stat(path .. '/.luarc.jsonc') then
              --     client.config.settings = vim.tbl_deep_extend('force', client.config.settings.Lua, {
              --       runtime = {
              --         -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
              --         version = 'LuaJIT'
              --       },
              --       -- Make the server aware of Neovim runtime files
              --       workspace = {
              --         library = { vim.env.VIMRUNTIME }
              --         -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
              --         -- library = vim.api.nvim_get_runtime_file("", true)
              --       }
              --     })
              --
              --     client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
              --   end
              --   return true
              -- end
            elseif server_name == "pyright" then
              lsp_cfg["settings"] = {
                python = {
                  analysis = {
                    autoSearchPaths = true,
                    diagnosticMode = "workspace",
                    -- NOTE: 以下两行可以避免type-stubs所引起的问题
                    typeCheckingMode = 'off',
                    useLibraryCodeForTypes = true
                  }
                }
              }
            elseif server_name == "clangd" then
              lsp_cfg["cmd"] = {
                "clangd",
                -- NOTE: 现在是使用~/.config/clangd/config.yaml文件进行配置，详情请见
                -- NOTE: https://clangd.llvm.org/config#compileflags
              }
            end
            require("lspconfig")[server_name].setup(lsp_cfg);
          end,
          -- 下面提供的是本身lsp之外的配置，不要再次setup lsp-config，因为这意味着配置了两边
          -- Next, you can provide a dedicated handler for specific servers.
          -- For example, a handler override for the `rust_analyzer`:
          -- ["rust_analyzer"] = function ()
          --     require("rust-tools").setup {}
          -- end
        }
      else
        print("doesn't has mason-lspconfig")
      end
    end,
  },
}
