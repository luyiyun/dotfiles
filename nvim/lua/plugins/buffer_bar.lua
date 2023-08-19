return {

  {
    "romgrk/barbar.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      'lewis6991/gitsigns.nvim',
    },
    init = function() vim.g.barbar_auto_setup = false end,
    opts = {},
    keys = {
      {"<A-h>", "<cmd>BufferPrevious<cr>", desc = "previous buffer"},
      {"<A-l>", "<cmd>BufferNext<cr>", desc = "next buffer"},
      {"<A-p>", "<cmd>BufferPin<cr>", desc = "pin buffer"},
      {"<A-q>", "<cmd>BufferClose<cr>", desc = "close buffer"},
      {"<A-q>", "<cmd>BufferClose<cr>", desc = "close buffer"},
      {"<A-v>", "<cmd>BufferCloseAllButVisible<cr>", desc = "close all buffers but visible"},
    },
    config = function(_, opts)
      require("barbar").setup(opts)
      -- can restore the order that your buffers were in, as well as whether a buffer was pinned
      vim.opt.sessionoptions:append 'globals'
      vim.api.nvim_create_user_command(
        'Mksession',
        function(attr)
          vim.api.nvim_exec_autocmds('User', {pattern = 'SessionSavePre'})
          -- Neovim 0.8+
          vim.cmd.mksession {bang = attr.bang, args = attr.fargs}
          -- Neovim 0.7
          -- vim.api.nvim_command('mksession ' .. (attr.bang and '!' or '') .. attr.args)
        end,
        {bang = true, complete = 'file', desc = 'Save barbar with :mksession', nargs = '?'}
      )

      -- 当目录树打开时，令bufferline的左侧有一块特定的区域
      -- 这里我们改用专属于nvim-tree的特定解决方案
      local ok, nvim_tree_events = pcall(require, "nvim-tree.events")  -- 这样可以保证之后存在nvim-tree的插件时才会调用该函数
      if ok then
        local bufferline_api = require('bufferline.api')
        local function get_tree_size() return require'nvim-tree.view'.View.width end
        nvim_tree_events.subscribe('TreeOpen', function() bufferline_api.set_offset(get_tree_size()) end)
        nvim_tree_events.subscribe('Resize', function() bufferline_api.set_offset(get_tree_size()) end)
        nvim_tree_events.subscribe('TreeClose', function() bufferline_api.set_offset(0) end)
      end
    end

  },
}
