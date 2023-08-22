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
            handlers = {},
        })
        local null_ls = require("null-ls")
        null_ls.setup({ sources = {} })
    end
  }
}
