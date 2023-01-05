-- ╭────────────────────────────────────────────────────────────────────────────────────────────────────────────────╮
-- │ 底部状态栏美化插件                                                                                             │
-- │ docs: https://github.com/feline-nvim/feline.nvim                                                               │
-- │ components: https://github.com/feline-nvim/feline.nvim/blob/master/lua/feline/default_components.lua           │
-- ╰────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯

local feline       = loadModule("feline", "plugin-config")
local felineUtils  = loadModule("feline.utils", "plugin-config")
local lazy_require = felineUtils.lazy_require;
local vi_mode      = lazy_require('feline.providers.vi_mode')

vim.opt.laststatus = 3 -- NOTE:可以让多个窗口使用一个statusline，也可以通过设置inactive components来使不同的窗口有不同的statusline

local colors = {
  bg         = "#080808",
  fg         = "#e5e5e5",
  section_bg = "#38393f",
  blue       = "#61afef",
  green      = "#98c379",
  purple     = "#c678dd",
  orange     = "#e5c07b",
  red        = "#e06c75",
  yellow     = "#e5c07b",
  darkgrey   = "#2c323d",
  middlegrey = "#8791A5",
  gitred     = "#d44e32",
}
local vi_mode_colors = {
  NORMAL        = "green",
  OP            = "red",
  INSERT        = "blue",
  VISUAL        = "purple",
  LINES         = "purple",
  BLOCK         = "purple",
  REPLACE       = "red",
  ["V-REPLACE"] = "purple",
  ENTER         = "blue",
  MORE          = "blue",
  SELECT        = "orange",
  COMMAND       = "green",
  SHELL         = "green",
  TERM          = "blue",
  NONE          = "yellow"
}

local function mode()
  local mode_alias = {
    ["n"]    = "NORMAL",
    ["no"]   = "OP",
    ["nov"]  = "OP",
    ["noV"]  = "OP",
    ["no"]  = "OP",
    ["niI"]  = "NORMAL",
    ["niR"]  = "NORMAL",
    ["niV"]  = "NORMAL",
    ["v"]    = "VISUAL",
    ["V"]    = "V-LINE",
    [""]    = "V-BLOCK",
    ["s"]    = 'SELECT',
    ["S"]    = "SELECT",
    [""]    = "V-BLOCK",
    ["i"]    = "INSERT",
    ["ic"]   = "INSERT",
    ["ix"]   = "INSERT",
    ["R"]    = "REPLACE",
    ["Rc"]   = "REPLACE",
    ["Rv"]   = "V-REPLACE",
    ["Rx"]   = "REPLACE",
    ["c"]    = "COMMAND",
    ["cv"]   = "COMMAND",
    ["ce"]   = "COMMAND",
    ["r"]    = "ENTER",
    ["rm"]   = "MORE",
    ["r?"]   = "CONFIRM",
    ["!"]    = "SHELL",
    ["t"]    = "TERMINAL",
    ["nt"]   = "NORMAL",
    ["null"] = "NONE",
  }
  return mode_alias[vim.api.nvim_get_mode().mode]
end

-- 分割符号
local sep = {
  left = 'slant_left',
  right = 'slant_right_2',
}

-- -----------------------------------------------------------------------------
-- 代码诊断计数函数
-- -----------------------------------------------------------------------------
local function get_diagnostic_count(severity)
  local count = #vim.diagnostic.get(0, { severity = severity })
  return count ~= 0 and count .. " " or ''
end

-- -----------------------------------------------------------------------------
-- statusline中包含的组件
-- -----------------------------------------------------------------------------
local components = {
  active = {
    {
      -- -----------------------------------------------------------------------------
      -- VIM 模式信息提示(左)
      -- -----------------------------------------------------------------------------
      {
        name = "mode",
        provider = function() return string.format(" %s ", mode()) end,
        short_provider = function() return string.format(" %s ", mode():sub(1, 1)) end,
        hl = function() return { fg = "bg", bg = vi_mode.get_mode_color(), style = "bold" } end,
        icon = " ",
        left_sep = {},
        right_sep = { sep.right },
      },
      {
        name = "rootdir",
        provider = function()
          local rootDir = table.remove(vim.fn.split(vim.fn.getcwd(), '/'));
          if rootDir ~= nil then
            return rootDir .. " ";
          end
          return "";
        end,
        icon = "  ",
        hl = { fg = "white", bg = "oceanblue" },
        left_sep = { sep.left },
        right_sep = { sep.right }
      },
      {
        name = "git",
        provider = function()
          local branch = vim.b.gitsigns_head or "not-git-repo";
          return branch .. " ";
        end,
        icon = '  ',
        hl = { fg = 'fg', bg = 'gitred' },
        left_sep = { sep.left },
        right_sep = { sep.right }
      },
      {
        name      = "git-add",
        provider  = "git_diff_added",
        icon      = "+",
        hl        = { fg = "green", bg = "bg" },
        left_sep  = " ",
        right_sep = " ",
      },
      {
        name      = "git-change",
        provider  = "git_diff_changed",
        icon      = "~",
        hl        = { fg = "orange", bg = "bg" },
        left_sep  = " ",
        right_sep = " ",
      },
      {
        name     = "git-remove",
        provider = "git_diff_removed",
        icon     = "-",
        hl       = { fg = "red", bg = "bg" },
      },
      {
        name = "diag-error",
        provider = function() return get_diagnostic_count(vim.diagnostic.severity.ERROR) end,
        icon = "  ",
        hl = { fg = "red", bg = "bg" },
      },
      {
        name = "diag-warn",
        provider = function() return get_diagnostic_count(vim.diagnostic.severity.WARN) end,
        icon = "  ",
        hl = { fg = "orange", bg = "bg" },
      },
      {
        name = "diag-info",
        provider = function() return get_diagnostic_count(vim.diagnostic.severity.INFO) end,
        icon = "  ",
        hl = { fg = "blue", bg = "bg" },
      },
    },
    {
      -- -----------------------------------------------------------------------------
      -- 其他提示信息(右)
      -- -----------------------------------------------------------------------------
      {
        name = "date",
        provider = function() return vim.fn.strftime("%F") end,
        right_sep = { " ", { str = "vertical_bar_thin", hl = { fg = "fg" } } },
      },
      {
        name = "terminal",
        provider = function()
          local m = vim.api.nvim_get_mode().mode
          if m == "nt" or m == "t" then
            return "terminal " .. vim.b.toggle_number
          else
            return ""
          end
        end,
        left_sep = " ",
        right_sep = { " ", { str = "vertical_bar_thin", hl = { fg = "fg" } } },
      },
      {
        name = "lsp",
        provider = function()
          local clients = vim.lsp.get_active_clients({ bufnr = vim.api.nvim_buf_get_number(0) })
          if #clients == 0 then
            return ""
          elseif #clients == 1 then
            return clients[1].name
          else
            local name = ""
            for _, v in ipairs(clients) do
              name = name .. v.name
            end
            return name
          end
        end,
        left_sep = " ",
        right_sep = { " ", { str = "vertical_bar_thin", hl = { fg = "fg" } } },
      },
      {
        name = "position",
        provider = "position",
        right_sep = " ",
        left_sep = " ",
      },
      {
        name = "line-percent",
        provider = "line_percentage",
        right_sep = { " ", { str = "vertical_bar_thin", hl = { fg = "fg" } } },
      },
      {
        name = "file-size",
        provider = "file_size",
        right_sep = " ",
        left_sep = " "
      }
    }
  },
  inactive = { {} }, -- TODO: inactive window其statusline的配置方案
}


feline.setup({
  theme = colors,
  vi_mode_colors = vi_mode_colors,
  components = components,
  force_inactive = {
    filetypes = {
      "^packer$",
      "NvimTree",
      "^qf$",
      -- "^help$",
      "Outline",
      "Trouble",
      "dap-repl",
      "^dapui",
    },
    buftypes = {},
    bufnames = {},
  },
})
