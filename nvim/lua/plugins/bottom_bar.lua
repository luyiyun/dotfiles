return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    event = "VeryLazy",
    config = function()
      -- 得到当前lsp的名称
      local function lsp_info()
        local clients = vim.lsp.get_active_clients({bufnr = 0})
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
        if has_vs then
          local venv_name = vs.get_active_venv()
          if venv_name ~= nil then
            return string.gsub(venv_name, ".*/mambaforge/envs/", "(mamba) ")
          end
        end
        return ""
      end

      require("lualine").setup{
        options = {
          icons_enabled = true,
          theme = 'auto',
          component_separators = { left = '', right = ''},
          section_separators = { left = '', right = ''},
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
          lualine_a = {'mode'},
          lualine_b = {'branch', 'diff', 'diagnostics'},
          lualine_c = {'filename'},
          lualine_x = {'encoding', lsp_info, venv_info, 'filetype'},
          lualine_y = {'progress'},
          lualine_z = {'location'}
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {'filename'},
          lualine_x = {'location'},
          lualine_y = {},
          lualine_z = {}
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {}
      }
    end
  }
}
