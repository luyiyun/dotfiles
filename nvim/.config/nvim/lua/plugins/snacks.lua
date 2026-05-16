-- ~/.config/nvim/lua/plugins/snacks.lua
-- 没有成功
return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          -- <leader>ff / <leader><space> 这类文件查找
          files = {
            hidden = true,
            -- 一般不建议默认 ignored = true，否则 node_modules 等也可能进来
            -- ignored = true,
          },

          -- <leader>sg 这类全文搜索
          grep = {
            hidden = true,
            -- ignored = true,
          },

          -- <leader>sw 搜索当前光标词
          grep_word = {
            hidden = true,
            -- ignored = true,
          },

          -- 如果你也用 snacks explorer
          explorer = {
            hidden = true,
            -- ignored = true,
          },
        },
      },
    },
  },
}
