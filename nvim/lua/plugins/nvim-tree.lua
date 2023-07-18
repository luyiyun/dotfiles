return {
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = 'nvim-tree/nvim-web-devicons', -- optional, for file icons
    keys = {
      -- {"<leader>tt", function ()
      --   require("nvim-tree.api").tree.toggle({path = get_root()})
      -- end, desc = "toggle file explorer[nvim-tree]"},
      -- NOTE:使用下面的sync_root_with_cwd配置也可以达到目的
      {"<leader>tt", "<cmd>NvimTreeToggle<CR>", desc = "toggle file explorer[nvim-tree]"},
      {"<leader>tf", "<cmd>NvimTreeFocus<CR>", desc = "focus in explorer[nvim-tree]"},
      -- {"<leader>tr", "<cmd>NvimTreeRefresh<CR>", desc = "refresh file explorer[nvim-tree]"},
      -- {"<leader>to", "<cmd>NvimTreeFindFileToggle<CR>", desc = "toggle file finder explorer[nvim-tree]"}
    },
    config = function()
      vim.g.loaded_netrw       = 1
      vim.g.loaded_netrwPlugin = 1
      require("nvim-tree").setup({
        disable_netrw = true,
        hijack_netrw = true,
        sync_root_with_cwd = true,  -- 自动根据当前的文件更新root
        update_focused_file = {
          enable = true,  -- 自动打开文件所在的路径
        }
      })
      -- require("nvim-tree.events").on_file_created(function(file) vim.cmd("edit " .. file.fname) end)
    end,
  },
}
