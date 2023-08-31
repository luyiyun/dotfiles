return {
  -- {
  --   "nvimdev/guard.nvim",
  --   event = "VeryLazy",
  --   config = function ()
  --     local ft = require('guard.filetype')
  --
  --     ft("lua"):fmt("stylua")
  --     ft("json"):fmt("jq")
  --     ft("python"):fmt("black"):append("isort")
  --
  --     -- Call setup() LAST!
  --     require('guard').setup({
  --         -- the only options for the setup function
  --         fmt_on_save = false,
  --         -- Use lsp if no formatter was defined for this filetype
  --         lsp_as_default_formatter = true,
  --     })
  --   end
  -- },
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
        "williamboman/mason.nvim",
        "jay-babu/mason-null-ls.nvim",
    },
    config = function()
        local linters = {
            "black",
            "prettier",
            "stylua",
            "jq",
            "black",
            "isort",
            "flake8"
        }
        require("mason-null-ls").setup({
            ensure_installed = linters,
            handlers = {
              -- black = function(source_name, methods)
              --
              -- end
            },
        })
        local null_ls = require("null-ls")
        null_ls.setup({ sources = {
          null_ls.builtins.formatting.black.with({
            extra_args = {"--line-length=79"},
          }),
          null_ls.builtins.diagnostics.flake8,
          -- ls.builtins.diagnostics.mypy.with({
          --   -- https://github.com/jose-elias-alvarez/null-ls.nvim/issues/1208#issuecomment-1343562820
          --   cwd = function (_) return vim.fn.getcwd() end,
          -- }),
          -- ls.builtins.diagnostics.shellcheck,
        } })
    end
  },
  -- {
  --   "mhartington/formatter.nvim",
  --   event = { "BufReadPost", "BufNewFile" },
  --   -- dependencies = {
  --   --     "williamboman/mason.nvim",
  --   --     "jay-babu/mason-null-ls.nvim",
  --   -- },
  --   opts = {
  --
  --   }
  -- }
}
