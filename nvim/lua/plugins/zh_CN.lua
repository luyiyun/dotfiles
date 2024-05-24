return {
  {
    "yehuohan/cmp-im", -- 提供中文输入的source
    dependencies = {
      "hrsh7th/nvim-cmp",
      -- "yehuohan/cmp-im-zh", -- 提供中文输入的码表，将该码表放入cmp-im的配置中，从而形成中文输入的source
    },
    event = "VeryLazy",
    keys = {
      {
        "<leader>zo",
        function()
          vim.notify(string.format('IM is %s',
            require("cmp_im").toggle() and 'enabled' or 'disabled'))
        end,
        desc = "toggle cmp-im"
      },
    },
    config = function()
      local cmp = require("cmp")
      local cmp_im = require("cmp_im")
      -- local cmp_im_zh = require("cmp_im_zh")
      cmp_im.setup {
        -- Enable/Disable IM
        enable = false,
        -- IM keyword pattern
        keyword = [[\l\+]],
        -- IM tables path array
        -- tables = cmp_im_zh.tables { "pinyin" },
        tables = { vim.fn.stdpath("config") .. "\\" .. "my_double_pin_repo.txt" },
        -- Function to format IM-key and IM-tex for completion display
        format = function(key, text) return vim.fn.printf('%-15S %s', text, key) end,
        -- Max number entries to show for completion of each table
        maxn = 8,
      }

      local config = cmp.get_config()
      table.insert(config.sources, {
        name = "IM", group_index = 2 -- 将其归入第二组，只有当lsp等没有提示时才出现
      })
      config.mapping["<Space>"] = cmp.mapping(cmp_im.select(), { 'i' })
      cmp.setup(config)
    end
  },
}
