vim.opt.list = true
-- vim.opt.listchars:append "eol:↴"

local indent = loadModule("indent_blankline", "plugin-configs/indent_blankline");
indent.setup({
  -- NOTE: 开启后会导致一些内容泄露到行号的左侧
  show_current_context = false,
  show_current_context_start = false,
  show_end_of_line = false,
})
