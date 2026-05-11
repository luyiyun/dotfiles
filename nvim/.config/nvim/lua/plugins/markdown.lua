-- ~/.config/nvim/lua/plugins/markdown-edit.lua
return {
  {
    "tadmccorkle/markdown.nvim",
    ft = { "markdown", "quarto" },
    opts = {
      -- 避免和 LazyVim/mini.surround 的 gs 映射冲突
      mappings = {
        inline_surround_toggle = "gM",
        inline_surround_toggle_line = "gMM",
        inline_surround_delete = "dm",
        inline_surround_change = "cm",
      },

      on_attach = function(bufnr)
        local map = vim.keymap.set

        local nopts = { buffer = bufnr, remap = true, silent = true }

        -- Normal 模式：作用于当前 word
        map(
          "n",
          "<leader>mb",
          "gMiwb",
          vim.tbl_extend("force", nopts, {
            desc = "Markdown toggle bold word",
          })
        )

        map(
          "n",
          "<leader>mi",
          "gMiwi",
          vim.tbl_extend("force", nopts, {
            desc = "Markdown toggle italic word",
          })
        )

        map(
          "n",
          "<leader>ms",
          "gMiws",
          vim.tbl_extend("force", nopts, {
            desc = "Markdown toggle strikethrough word",
          })
        )

        map(
          "n",
          "<leader>mc",
          "gMiwc",
          vim.tbl_extend("force", nopts, {
            desc = "Markdown toggle inline code word",
          })
        )

        -- Visual 模式：作用于选区
        local function visual_toggle(style)
          return ("<Esc>gv<Cmd>lua require('markdown.inline').toggle_emphasis_visual('%s')<CR>"):format(style)
        end

        local vopts = { buffer = bufnr, silent = true }

        map(
          "x",
          "<leader>mb",
          visual_toggle("b"),
          vim.tbl_extend("force", vopts, {
            desc = "Markdown toggle bold selection",
          })
        )

        map(
          "x",
          "<leader>mi",
          visual_toggle("i"),
          vim.tbl_extend("force", vopts, {
            desc = "Markdown toggle italic selection",
          })
        )

        map(
          "x",
          "<leader>ms",
          visual_toggle("s"),
          vim.tbl_extend("force", vopts, {
            desc = "Markdown toggle strikethrough selection",
          })
        )

        map(
          "x",
          "<leader>mc",
          visual_toggle("c"),
          vim.tbl_extend("force", vopts, {
            desc = "Markdown toggle inline code selection",
          })
        )
      end,
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "markdown",
        "markdown_inline",
      },
    },
  },
}
