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
        -- local linters = {
        --     "black",
        --     -- "prettier",
        --     -- "stylua",
        --     -- "jq",
        --     "isort",
        --     "flake8"
        -- }
        local null_ls = require("null-ls")
        local diagnostics = require("null-ls").builtins.diagnostics
        local formatting = require("null-ls").builtins.formatting

        null_ls.setup({ sources = {
          formatting.black.with({ extra_args = {"--line-length=79"} }),
          formatting.isort,
          diagnostics.flake8.with({ extra_args = {"--ignore=E731,W503"} }),
          -- E731: 使用def而不是lambda
          -- W503: binary break one line
        } })
        local mnl = require("mason-null-ls")
        mnl.setup({ ensure_installed = nil, automatic_installation = true })
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
