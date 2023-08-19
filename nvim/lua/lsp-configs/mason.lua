-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │  安装LSP服务器工具                                                           │
-- │  docs: https://github.com/williamboman/mason.nvim                            │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
local mason = loadModule("mason", "lsp");
local wk = loadModule("which-key", "plugin-configs")


wk.register({
    ["<leader>ma"] = {
      "<cmd>Mason<CR>", "Mason[mason]"
    }
})

mason.setup({
  -- keymaps = keymaps,
  -- max_concurrent_installers = 10,
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
})

-- return {
-- 	onstart = function()
-- 	end,
-- }
