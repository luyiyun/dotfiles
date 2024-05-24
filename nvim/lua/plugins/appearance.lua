return {

  ------------------------------------------------------------------
  -- Statusline using lua
  ------------------------------------------------------------------
  {
    'nvim-lualine/lualine.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    event = "VeryLazy",
    config = function()
      -- 得到当前lsp的名称
      local function lsp_info()
        local clients = vim.lsp.get_clients({ bufnr = 0 })
        if #clients == 0 then
          return ""
        elseif #clients == 1 then
          return clients[1].name
        else
          local name = nil
          for _, v in ipairs(clients) do
            if name == nil then
              name = v.name
            else
              name = name .. "/" .. v.name
            end
          end
          return name
        end
      end

      local function venv_info()
        local has_vs, vs = pcall(require, "venv-selector")
        local buf_id = vim.api.nvim_get_current_buf()
        local filename = vim.api.nvim_buf_get_name(buf_id)
        if filename:sub(-3) == ".py" then
          if has_vs then
            local python_path = vs.python()
            if python_path ~= nil then
              return python_path:gsub(".*\\envs\\", "(mamba) "):gsub("\\python.exe", "")
            end
          end
        end
        return ""
      end

      require("lualine").setup {
        options = {
          icons_enabled = true,
          theme = 'auto',
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
          ignore_focus = {},
          always_divide_middle = true,
          globalstatus = false,
          refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
          }
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch', 'diff', 'diagnostics' },
          lualine_c = { 'filename' },
          lualine_x = { 'encoding', lsp_info, venv_info, 'filetype' },
          lualine_y = { 'progress' },
          lualine_z = { 'location' }
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { 'filename' },
          lualine_x = { 'location' },
          lualine_y = {},
          lualine_z = {}
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {}
      }
    end
  },
  ------------------------------------------------------------------
  -- a VS Code like winbar in order to get LSP context and file name
  ------------------------------------------------------------------
  {
    "utilyre/barbecue.nvim",
    event = "VeryLazy",
    name = "barbecue",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    opts = {
      -- configurations go here
    },
  },

  ------------------------------------------------------------------
  -- tabline
  ------------------------------------------------------------------
  {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    event = "VeryLazy",
    opts = {
      options = {
        diagnostics = "nvim_lsp"
      }
    },
    keys = {
      { "<A-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "previous buffer" },
      { "<A-l>", "<cmd>BufferLineCycleNext<cr>", desc = "next buffer" },
      { "<A-p>", "<cmd>BufferLinePick<cr>",      desc = "pin buffer" },
      { "<A-q>", "<cmd>BufferLineClose<cr>", desc = "close buffer" },
    },
  },

  -- {
  --   "romgrk/barbar.nvim",
  --   event = "VeryLazy",
  --   dependencies = {
  --     "nvim-tree/nvim-web-devicons",
  --     'lewis6991/gitsigns.nvim',
  --   },
  --   init = function() vim.g.barbar_auto_setup = false end,
  --   opts = {},
  --   keys = {
  --     { "<A-h>", "<cmd>BufferPrevious<cr>",           desc = "previous buffer" },
  --     { "<A-l>", "<cmd>BufferNext<cr>",               desc = "next buffer" },
  --     { "<A-p>", "<cmd>BufferPin<cr>",                desc = "pin buffer" },
  --     { "<A-q>", "<cmd>BufferClose<cr>",              desc = "close buffer" },
  --     { "<A-v>", "<cmd>BufferCloseAllButVisible<cr>", desc = "close all buffers but visible" },
  --   },
  --   config = function(_, opts)
  --     require("barbar").setup(opts)
  --     -- can restore the order that your buffers were in, as well as whether a buffer was pinned
  --     vim.opt.sessionoptions:append 'globals'
  --     vim.api.nvim_create_user_command(
  --       'Mksession',
  --       function(attr)
  --         vim.api.nvim_exec_autocmds('User', { pattern = 'SessionSavePre' })
  --         -- Neovim 0.8+
  --         vim.cmd.mksession { bang = attr.bang, args = attr.fargs }
  --         -- Neovim 0.7
  --         -- vim.api.nvim_command('mksession ' .. (attr.bang and '!' or '') .. attr.args)
  --       end,
  --       { bang = true, complete = 'file', desc = 'Save barbar with :mksession', nargs = '?' }
  --     )
  --
  --     -- 当目录树打开时，令bufferline的左侧有一块特定的区域
  --     -- 这里我们改用专属于nvim-tree的特定解决方案
  --     local ok, nvim_tree_events = pcall(require, "nvim-tree.events") -- 这样可以保证之后存在nvim-tree的插件时才会调用该函数
  --     if ok then
  --       local bufferline_api = require('bufferline.api')
  --       local function get_tree_size() return require 'nvim-tree.view'.View.width end
  --       nvim_tree_events.subscribe('TreeOpen', function() bufferline_api.set_offset(get_tree_size()) end)
  --       nvim_tree_events.subscribe('Resize', function() bufferline_api.set_offset(get_tree_size()) end)
  --       nvim_tree_events.subscribe('TreeClose', function() bufferline_api.set_offset(0) end)
  --     end
  --   end
  --
  -- },

}
