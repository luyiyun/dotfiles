-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
--
vim.keymap.set("n", "-", ":noh<cr>", { desc = "remove the search highlight" })

-- unmap for moving lines
vim.keymap.del({ "n", "i", "v" }, "<A-j>")
vim.keymap.del({ "n", "i", "v" }, "<A-k>")

-- remap for moving lines
vim.keymap.set("n", "<C-J>", "<cmd>m .+1<cr>==", { desc = "Move Down" })
vim.keymap.set("n", "<C-K>", "<cmd>m .-2<cr>==", { desc = "Move Up" })
vim.keymap.set("i", "<C-J>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
vim.keymap.set("i", "<C-J>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
vim.keymap.set("v", "<C-J>", ":m '>+1<cr>gv=gv", { desc = "Move Down" })
vim.keymap.set("v", "<C-K>", ":m '<-2<cr>gv=gv", { desc = "Move Up" })

-- remap for formatting
vim.keymap.set({ "n", "v" }, "<leader>rf", function()
  LazyVim.format({ force = true })
end, { desc = "Format" })

-- remap for rename
vim.keymap.set({ "n", "v" }, "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })

local function has_treesitter()
  return vim.treesitter.get_parser(0, nil, { error = false }) ~= nil
end

-- normal 模式：开始选择当前语法节点
vim.keymap.set("n", "vv", function()
  vim.cmd("normal! v")

  if has_treesitter() then
    require("vim.treesitter._select").select_parent(1)
  else
    vim.lsp.buf.selection_range(1)
  end
end, { desc = "Start Treesitter/LSP Selection" })

-- visual 模式：继续扩大选择
vim.keymap.set("x", "vv", function()
  if has_treesitter() then
    require("vim.treesitter._select").select_parent(vim.v.count1)
  else
    vim.lsp.buf.selection_range(vim.v.count1)
  end
end, { desc = "Expand Treesitter/LSP Selection" })

-- visual 模式：缩小选择
vim.keymap.set("x", "VV", function()
  if has_treesitter() then
    require("vim.treesitter._select").select_child(vim.v.count1)
  else
    vim.lsp.buf.selection_range(-vim.v.count1)
  end
end, { desc = "Shrink Treesitter/LSP Selection" })
