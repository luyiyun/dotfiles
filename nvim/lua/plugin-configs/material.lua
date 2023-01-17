-- local material = loadModule("material", "plugin-configs/material")
local mfunction = loadModule("material.functions", "plugin-configs/material")
local wk = loadModule("which-key", "plugin-configs/material")

vim.cmd("colorscheme material")

wk.register({
  ["<leader>fc"] = {mfunction.find_style, "select material theme"}
})
