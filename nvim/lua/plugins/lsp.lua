return {
  -- ╭──────────────────────────────────────────────────────────────────────────────╮
  -- │                           MASON: lsp servers managers                        │
  -- ╰──────────────────────────────────────────────────────────────────────────────╯
  {
    "williamboman/mason.nvim", -- mason官方不推荐进行lazy loading
    -- build = ":MasonUpdate",
    opts = {
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
      "folke/neodev.nvim",                 -- 提供用于neovim插件开发的lua api的提示，需要保证在lspconfig之前启动
      -- NOTE: 为了应用neodev，首先需要将mason,mason-lspconfig,nvim-lspconfig都升级到
      -- NOTE: 最新版本，然后使用新的lua的LSP名称（lua_ls，而非sumneko_lua）
    },
    config = function()
      ------------------------------------------------------------------------------------
      -- 所有的lsp以及它们的配置
      -- 这里支持lsp，不支持linter和formatter等其他
      ------------------------------------------------------------------------------------
      local servers = {
        lua_ls = {
          settings = {
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
        },
        pyright = {
          settings = {
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
        },
        yamlls = {},
        -- clangd = {
        --   cmd = {
        --     "clangd",
        --     -- NOTE: 现在是使用~/.config/clangd/config.yaml文件进行配置，详情请见
        --     -- NOTE: https://clangd.llvm.org/config#compileflags
        --   }
        -- }
      }

      -- mason-lspconfig是对于mason的补充，用来更好的让mason和lspconfig两个插件共同工作
      -- 三个插件的启动顺序必须要保证：mason->mason-lspconfig->使用lspconfig来设置lsp server
      local has_mslp, mslp = pcall(require, "mason-lspconfig")
      if has_mslp then
        mslp.setup({
          automatic_installation = true, -- 自动安装LSP服务端
          -- 要安装的LSP服务:
          -- https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
          ensure_installed       = vim.tbl_keys(servers)
        })
      end

      ------------------------------------------------------------------------------------
      -- (配置) 代码诊断 diagnositc
      ------------------------------------------------------------------------------------
      local has_cmp_nlsp, cmp_nlsp = pcall(require, "cmp_nvim_lsp") -- 没有setup，就没有开启
      local has_lspsaga, _ = pcall(require, "lspsaga")

      ------------------------------------------------------------------------------------
      -- (配置) 代码诊断 diagnositc
      ------------------------------------------------------------------------------------
      if not has_lspsaga then
        -- 每当开启一个LSP时，其都会提供这个功能。这部分的配置主要包括两个部分：
        --  1. 如何展示诊断信息；
        --  2. 相关位置的代码跳转
        --
        -- 首先是左侧signcolumn的图标显示
        local signs = {
          { name = "DiagnosticSignError", text = "💢" }, -- ""
          { name = "DiagnosticSignWarn", text = "😱" }, -- ""
          { name = "DiagnosticSignHint", text = "🤔" }, -- ""
          { name = "DiagnosticSignInfo", text = "😐" }, -- ""
        }
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
      end

      ------------------------------------------------------------------------------------
      -- (配置) 代码补全 complete,
      --        定义跳转 go defination,
      --        悬停 hover,
      --        重命名 rename,
      --        格式化 format,
      --        code action
      ------------------------------------------------------------------------------------
      if not has_lspsaga then
        vim.api.nvim_create_autocmd('LspAttach', {
          group = vim.api.nvim_create_augroup('UserLspConfig', {}),
          callback = function(ev)
            if not has_cmp_nlsp then -- 如果没有cmp，则设置手动版本
              -- Enable completion triggered by <c-x><c-o>
              vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
            end

            -- Buffer local mappings.
            -- See `:help vim.lsp.*` for documentation on any of the below functions
            local opts = { buffer = ev.buf }
            -- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
            -- go defination
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
            -- hover
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
            -- rename
            vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
            -- code action
            vim.keymap.set({ 'n', 'v' }, '<space>ra', vim.lsp.buf.code_action, opts)
            -- format
            vim.keymap.set('n', '<space>rf', function() vim.lsp.buf.format { async = true } end, opts)

            -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
            -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
            -- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
            -- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
            -- vim.keymap.set('n', '<space>wl', function()
            --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            -- end, opts)
            -- vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
            -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
          end,
        })
      end

      ------------------------------------------------------------------------------------
      -- 启动LSP
      ------------------------------------------------------------------------------------
      require("neodev").setup({})
      -- 正常启动lsp的方式（使用lspconfig的api）: require("lspconfig").lua_ls.setup({})
      -- 但是，这里我们使用mason-lspconfig的api，其可以保证在需要的时候自动开启lsp server
      if has_mslp then
        mslp.setup_handlers {
          -- The first entry (without a key) will be the default handler
          -- and will be called for each installed server that doesn't have
          -- a dedicated handler.
          function(server_name) -- default handler (optional)
            -- local lsp_cfg = { on_attach = on_attach }
            local lsp_cfg = {}
            if has_cmp_nlsp then
              lsp_cfg["capabilities"] = cmp_nlsp.default_capabilities()
            end
            require("lspconfig")[server_name].setup(
              vim.tbl_deep_extend("keep", lsp_cfg, servers[server_name])
            );
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
  -- ╭──────────────────────────────────────────────╮
  -- │               beautiful LSP                  │
  -- ╰──────────────────────────────────────────────╯
  -- {
  --   'nvimdev/lspsaga.nvim',
  --   event = "LspAttach",
  --   dependencies = {
  --       'nvim-treesitter/nvim-treesitter', -- optional
  --       'nvim-tree/nvim-web-devicons'     -- optional
  --   },
  --   opts = {},
  --   keys = {
  --     {"gf", "<cmd>Lspsaga finder<CR>", desc = "Lspsaga finder[lspsaga]"},
  --     {"]d", "<cmd>Lspsaga diagnostic_jump_next", desc = "Lspsaga jump next diag"},
  --     {"[d", "<cmd>Lspsaga diagnostic_jump_prev", desc = "Lspsaga jump previous diag"},
  --     {"gd", "<cmd>Lspsaga peek_definition<CR>", desc = "Lspsaga go to definition[lspsaga]"},
  --     {"K", "<cmd>Lspsaga hover_doc<CR>", desc = "Lspsaga hover[lspsaga]"},
  --     {"<leader>rn", "<cmd>Lspsaga rename<CR>", desc = "Lspsaga rename"},
  --     -- {"<leader>dl", "<cmd>Lspsaga show_line_diagnostics<CR>", desc = "Show line diagnostics[lspsaga]"},
  --     -- {"<leader>dc", "<cmd>Lspsaga show_cursor_diagnostics<CR>", desc = "Show cursor diagnostics[lspsaga]"},
  --     -- {"<leader>da", "<cmd>Lspsaga code_action<CR>", desc = "code action quickFix[lspsaga]"},
  --     -- {"<leader>ds", "<cmd>LSoutlineToggle<CR>", desc = "show symbols[]"},
  --     -- {"<leader>dr", "<cmd>Lspsaga rename<CR>", desc = "edit symbol name[lspsaga]"},
  --   },
  -- }
}
