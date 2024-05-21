return {
  -- 补全引擎
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",                -- 使cmp可以利用到lsp中的source
      "hrsh7th/cmp-buffer",                  -- { name = 'buffer' },
      "hrsh7th/cmp-path",                    -- { name = 'path' }
      "hrsh7th/cmp-cmdline",                 -- { name = 'cmdline' }
      "rafamadriz/friendly-snippets",        -- 常见编程语言 snippets片段，与vsnip、luasnips等完美融合
      "hrsh7th/vim-vsnip",                   -- vim-vsnip 插件，vscode-like snippets engine
      "hrsh7th/cmp-vsnip",                   -- 使cmp可以利用到vsnip中的source
      "hrsh7th/cmp-nvim-lsp-signature-help", -- 显示函数签名，并显示当前参数
      -- use({ "hrsh7th/cmp-nvim-lua" })                  -- { name = 'nvim_lua' }
      "onsails/lspkind.nvim",                -- 为提示提供一些图标表示
    },
    config = function()
      local cmp = require("cmp")
      local has_autopair, autopair_cmp = pcall(require, "nvim-autopairs.completion.cmp")
      local lspkind = require("lspkind")

      -- 用于配置vsnip的mapping
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local feedkey = function(key, mode)
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
      end

      -- 补全时自动将括号加入
      if has_autopair then
        cmp.event:on('confirm_done', autopair_cmp.on_confirm_done())
      end

      cmp.setup({
        -- 设置快捷键
        -- 快捷键绑定，这里快捷键绑定设置与neovim的不同：
        -- 1. 可以直接使用一个函数，其接受fallback函数作为参数（fallback表示该按键正常的功能）
        -- 2. 当需要在特定模式进行设置时，需要使用到cmp.mapping函数（具体使用方式可以查看:h cmp）
        -- 3. 其内置了一系列的函数，可以直接用于进行配置
        -- 这里的mapping可以直接是一个table，也可以使用preset.insert将
        --  tabel再封装一下，该函数的作用是将一些默认的insert mode下
        --  的快捷键加入到我们自定义的table中再返回。如果我们确认不会
        --  用到这些默认快捷键的话，是可以不使用这个函数的。
        -- mapping = cmp.mapping.preset.insert({
        mapping = {
          -- 确定选中提示
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          -- 关闭代码提示
          ["<c-q>"] = cmp.mapping({
            -- 使用q键取消，会保持在insert模式，但是通过补全得到的内容将取消
            i = cmp.mapping.abort(), -- abort可以回到补全之前的状态
            c = cmp.mapping.close(),
          }),
          ["<ESC>"] = cmp.mapping({
            -- cmp.mapping.close的问题是，其会回到insert模式下，这意味着还需要再按一次esc才能回到normal模式
            -- cmp.mapping.abort的问题和close相同，但是其不会保留补全的内容
            -- 利用下面的配置，则可以让esc同时实现取消补全+回到normal模式（我更加喜欢使用normal模式下进行删除)
            i = function(fallback)
              if cmp.visible() then
                cmp.close()
                vim.cmd("stopinsert")
              else
                fallback()
              end
            end,
            c = cmp.mapping.close(),
          }),
          -- scroll_docs好像有问题，无法使用
          -- ['<C-f>'] = cmp.mapping.scroll_docs(-4),
          -- ['<C-b>'] = cmp.mapping.scroll_docs(4),
          -- 这里，我们配置tab有三个功能：
          -- 1. 下一个，2. 选择snippets，3. 如果前面有字的话就是启动补全
          -- 4. 如果以上的情况都不是，则直接使用tab的功能
          ["<Tab>"] = cmp.mapping(
            function(fallback)
              if cmp.visible() then
                cmp.select_next_item();
              elseif vim.fn["vsnip#available"](1) == 1 then
                feedkey("<Plug>(vsnip-expand-or-jump)", "")
              elseif has_words_before() then
                cmp.complete();
              else
                -- fallback函数是一个特殊的函数，其执行当前按键原来的行为
                -- fallback("<Tab>", "")
                fallback()
              end
            end,
            { "i", "s" }
          ),
          -- shift-tab: 上一个提示
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item();
            elseif vim.fn["vsnip#jumpable"](-1) == 1 then
              feedkey("<Plug>(vsnip-jump-prev)", "")
            else
              fallback()
            end
          end, { "i", "s" }),
        },

        -- Disabling completion in certain contexts, such as comments
        enabled = function()
          -- disable completion in comments
          local context = require 'cmp.config.context'
          -- keep command mode completion enabled when cursor is in commandline
          if vim.api.nvim_get_mode().mode == 'c' then
            return true
          else
            -- 如果使用nvim-treesitter
            return not context.in_treesitter_capture("comment")
            -- 如果不使用nvim-treesitter
            -- return not context.in_syntax_group("Comment")
          end
        end,

        -- 指定 snippets 引擎:
        -- docs: https://github.com/hrsh7th/nvim-cmp/wiki/List-of-sources
        snippet = {
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
            -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
          end,
        },
        window = {
          -- completion = cmp.config.window.bordered(),
          -- documentation = cmp.config.window.bordered(),
        },
        -- 配置补全所用的源
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'path' },
          { name = 'vsnip' }, -- For vsnip users.
          { name = "nvim_lsp_signature_help" },
          -- { name = 'luasnip' }, -- For luasnip users.
          -- { name = 'ultisnips' }, -- For ultisnips users.
          -- { name = 'snippy' }, -- For snippy users.
        }, { name = 'buffer' }), -- 这样，buffer的group_index被设置为2，而其他的source被设置为1，当group1被放入备选列表的时候，group2会被忽略

        -- 补全提示时使用的图标
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol_text",
            -- menu = ({
            --   nvim_lsp = "[LSP]",
            --   buffer = "[Buffer]",
            --   vsnip = "[VSnip]",
            --   path = "[Path]",
            --   -- luasnip = "[LuaSnip]",
            -- })
            before = function(entry, vim_item)
              local lspkind_icons = {
                Text = "",
                Method = "",
                Function = "",
                Constructor = "",
                Field = "ﰠ",
                Variable = "",
                Class = "ﴯ",
                Interface = "",
                Module = "",
                Property = "ﰠ",
                Value = "",
                Enum = "",
                Keyword = "",
                Snippet = "",
                Color = "",
                File = "",
                Reference = "",
                Folder = "",
                EnumMember = "",
                Constant = "",
                Struct = "פּ",
                Event = "",
                Operator = "",
                TypeParameter = ""
              }
              local meta_type = vim_item.kind
              vim_item.kind = lspkind_icons[vim_item.kind] or "";
              vim_item.menu = ({
                nvim_lsp                = " [" .. string.lower(meta_type) .. "]",
                buffer                  = " [Buffer]",
                vsnip                   = " [VSnip]",
                path                    = " [Path]",
                -- nvim_lua                = " [nvim_lua]",
                nvim_lsp_signature_help = " [Signature_Help]",
              })[entry.source.name]

              return vim_item
            end
          })
        }

      })

      -- 指定加载自定义 snippets 目录
      vim.g.vsnip_snippet_dir = vim.fn.stdpath("config") .. "/snippets";

      -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = { { name = 'buffer' } }
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({ { name = 'path' } }, { { name = 'cmdline' } })
      })
    end

  },
}
