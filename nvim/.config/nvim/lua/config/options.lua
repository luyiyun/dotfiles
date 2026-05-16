-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Python LSP：更推荐 basedpyright；如果想稳妥保守，可改回 "pyright"
vim.g.lazyvim_python_lsp = "basedpyright"
-- Ruff 使用新版 ruff server，不要再用旧的 ruff_lsp
vim.g.lazyvim_python_ruff = "ruff"
