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

local keymaps = {
  toggle_package_expand   = "o", -- 展开
  install_package         = "i", -- 安装
  update_package          = "u", -- 更新
  update_all_packages     = "U", -- 更新所有
  check_package_version   = "c", -- 检查版本
  check_outdated_packages = "C", -- 检查所有
  uninstall_package       = "X", -- 删除
  cancel_installation     = "<C-c>", -- 取消安装
  apply_language_filter   = "<C-f>", -- 筛选
}

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
