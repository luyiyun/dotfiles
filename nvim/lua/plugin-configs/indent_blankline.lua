vim.opt.list = true
vim.opt.listchars:append "eol:↴"

local indent = loadModule("indent_blankline", "plugin-configs");
indent.setup({
  show_current_context = true,
  show_current_context_start = true,
  show_end_of_line = true,
})
