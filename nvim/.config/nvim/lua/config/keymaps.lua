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
