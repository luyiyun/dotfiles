-- local function get_python_path()
--   local cwd = vim.fn.getcwd()
--   local venv = cwd .. "/.venv/bin/python"
--
--   if vim.fn.has("win32") == 1 then
--     venv = cwd .. "\\.venv\\Scripts\\python.exe"
--   end
--
--   if vim.fn.executable(venv) == 1 then
--     return venv
--   end
--
--   return vim.fn.exepath("python3") ~= "" and vim.fn.exepath("python3") or "python"
-- end

return {
  -- 让 conform 使用 ruff 做格式化和 import 排序
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      opts.formatters_by_ft.python = { "ruff_organize_imports", "ruff_format" }
    end,
  },

  -- -- 测试：让 neotest-python 明确使用当前项目 .venv
  -- {
  --   "nvim-neotest/neotest",
  --   opts = function(_, opts)
  --     opts.adapters = opts.adapters or {}
  --     opts.adapters["neotest-python"] = {
  --       runner = "pytest",
  --       python = get_python_path,
  --       pytest_discover_instances = true,
  --     }
  --   end,
  -- },
  --
  -- -- 调试：给 nvim-dap 一个明确的 Python 配置
  -- {
  --   "mfussenegger/nvim-dap",
  --   opts = function()
  --     local dap = require("dap")
  --
  --     dap.configurations.python = dap.configurations.python or {}
  --
  --     table.insert(dap.configurations.python, {
  --       type = "python",
  --       request = "launch",
  --       name = "Launch current file",
  --       program = "${file}",
  --       cwd = "${workspaceFolder}",
  --       console = "integratedTerminal",
  --       justMyCode = false,
  --       pythonPath = get_python_path,
  --     })
  --
  --     table.insert(dap.configurations.python, {
  --       type = "python",
  --       request = "launch",
  --       name = "Launch module",
  --       module = vim.fn.input("Module: "),
  --       cwd = "${workspaceFolder}",
  --       console = "integratedTerminal",
  --       justMyCode = false,
  --       pythonPath = get_python_path,
  --     })
  --   end,
  -- },
}
