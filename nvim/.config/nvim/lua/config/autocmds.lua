-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "quarto", "rmd" },
  callback = function()
    vim.opt_local.wrap = true -- 开启软换行
    vim.opt_local.linebreak = true -- 软换行在字符处断开，而不是单词中间
    vim.opt_local.breakindent = true -- 换行后保持缩进
    vim.opt_local.showbreak = "↳ " -- 给视觉续航加一个提示符

    vim.opt_local.textwidth = 80 --
    vim.opt_local.formatoptions:append("t")

    -- jk按照视觉行来移动
    vim.keymap.set("n", "j", "gj", { buffer = true, silent = true })
    vim.keymap.set("n", "k", "gk", { buffer = true, silent = true })
    vim.keymap.set("n", "0", "g0", { buffer = true, silent = true })
    vim.keymap.set("n", "$", "g$", { buffer = true, silent = true })
  end,
})
