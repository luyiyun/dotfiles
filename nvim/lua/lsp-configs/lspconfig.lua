-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │  配置LSP服务器工具                                                           │
-- │  docs: https://github.com/neovim/nvim-lspconfig                              │
-- │  docs: https://github.com/williamboman/mason-lspconfig.nvim                  │
-- │  docs: https://github.com/hrsh7th/nvim-cmp                                   │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
-- local lspconfig       = loadModule("lspconfig", "lsp");
local mason_lspconfig = loadModule("mason-lspconfig", "lsp");
local cmp_nvim_lsp    = loadModule("cmp_nvim_lsp", "lsp");
local wk              = loadModule("which-key", "lsp");


-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │                             启动mason-lspconfig                              │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
-- 这是一个对于mason plugin的补充，用来更好的让mason和lspconfig两个插件共同工作
-- 三个插件的启动顺序必须要保证：mason->mason-lspconfig->使用lspconfig来设置lsp server
mason_lspconfig.setup({
  automatic_installation = false, -- 自动安装LSP服务端
  -- 要安装的LSP服务:
  -- https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
  ensure_installed       = {
    "sumneko_lua",
    "clangd",
    "pyright",
    "yamlls",
  }
});


-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │                                     lspconfig                                │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
-- lsp server提供的功能主要有：代码诊断(diagnostic)、定义跳转(tagfunc\go-defination)、
--  格式整理(format)、光标悬停(hover)、代码自动补全()、代码修复(reference\implement\code_action)、
-- 某个LSP server可能只拥有以上功能中的几个，所以其会对应一个capabilities来说明这个问题
-- 现在我们逐个对以上功能进行配置


------------------------------------------------------------------------------------
-- 代码诊断 diagnositc
------------------------------------------------------------------------------------
-- 每当开启一个LSP时，其都会提供这个功能。这部分的配置主要包括两个部分：
--  1. 如何展示诊断信息；
--  2. 相关位置的代码跳转

-- 首先是左侧signcolumn的图标显示
local signs = {
  { name = "DiagnosticSignError", text = "💢" },
  { name = "DiagnosticSignWarn", text = "😱" },
  { name = "DiagnosticSignHint", text = "🤔" },
  { name = "DiagnosticSignInfo", text = "😐" },
}
-- local signs = {
--   { name = "DiagnosticSignError", text = "" },
--   { name = "DiagnosticSignWarn",  text = "" },
--   { name = "DiagnosticSignHint",  text = "" },
--   { name = "DiagnosticSignInfo",  text = "" },
-- }
for _, sign in ipairs(signs) do -- 提示信息图标设置
  vim.fn.sign_define(sign.name, {
    texthl = sign.name,
    text   = sign.text
  })
end
-- 配置代码诊断选项
-- 文档: :h vim.diagnostic.config()
vim.diagnostic.config({
  virtual_text     = true, -- 是否显示显示提示文字
  update_in_insert = true,
  underline        = true,
  severity_sort    = true,
  signs            = true, -- 显示图标
  -- NOTE: 这里会报错(虽然严格遵照了文档中的写法)
  -- format = function(diagnostic)
  --   if diagnostic.severity == vim.diagnostic.severity.ERROR then
  --     return string.format("Error: %s", diagnostic.message)
  --   end
  --   return diagnostic.message
  -- end,
  -- NOTE:并没有在文档中找到相关的配置
  -- float            = {
  --   focusable      = false,
  --   style          = "minimal",
  --   border         = "rounded",
  --   source         = "always",
  --   header         = "",
  --   prefix         = "",
  -- },
})
-- 现在是代码诊断的相关跳转快捷键设置
wk.register({
  ["<leader>d"] = {
    name = "code diagnostic",
    o = { vim.diagnostic.open_float, "open floating window" };
    q = { vim.diagnostic.setloclist, "set local list" };
  },
  ["["] = { name = "go to previous ..." },
  ["[d"] = { vim.diagnostic.goto_prev, "go to previous diagnostic position" };
  ["]"] = { name = "go to next ..." },
  ["]d"] = { vim.diagnostic.goto_next, "go to next diagnostic position" };
})
-- 除了代码诊断之外的其他快捷键配置，将使用一个on_attach函数传入lsp内部，只有在其
-- 生效的buffer上启用
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(_, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  -- 补全我们使用cmp来完成，不使用手动补全

  -- Mappings. 我们使用which key来实现。
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { mode = "n", noremap = true, silent = true, buffer = bufnr }
  wk.register({
    ------------------------------------------------------------------------------------
    -- 定义跳转
    ------------------------------------------------------------------------------------
    ["g"] = { name = "go to defination or declaration" },
    ["gd"] = { vim.lsp.buf.definition, "go to defination" },
    ["gD"] = { vim.lsp.buf.lsp_document_symbols, "go to declaration" },
    ["gi"] = { vim.lsp.buf.implementation, "go to implementation" },
    -- ["<leader>fd"] = {"<cmd>Telescope lsp_definitions<cr>", "List all definations"},
    ["<leader>fy"] = { "<cmd>Telescope lsp_document_symbols<cr>", "List all document symbols" },
    ------------------------------------------------------------------------------------
    -- 光标悬停 hover
    ------------------------------------------------------------------------------------
    ["<leader>h"] = { vim.lsp.buf.hover, "Hover" },
    ------------------------------------------------------------------------------------
    -- 格式和代码修复
    ------------------------------------------------------------------------------------
    ["<leader>r"] = { name = "code fix" },
    ["<leader>rf"] = { function() vim.lsp.buf.format { async = true } end, "formatting" },
    ["<leader>rn"] = { vim.lsp.buf.rename, "rename" },
    ["<leader>ra"] = { vim.lsp.buf.code_action, "code action" },
  }, bufopts)
end

------------------------------------------------------------------------------------
-- 代码自动补全
------------------------------------------------------------------------------------
local capabilities = cmp_nvim_lsp.default_capabilities();
-- 以上on_attach函数需要一个一个传入每个lsp中。mason-lspconfig提供了更加方便的方式：
-- local capabilities = vim.lsp.protocol.make_client_capabilities();
-- capabilities = cmp_nvim_lsp.default_capabilities(capabilities);
mason_lspconfig.setup_handlers {
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn't have
  -- a dedicated handler.
  function(server_name) -- default handler (optional)
    local lsp_cfg = {
      capabilities = capabilities,
      on_attach = on_attach,
    }
    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
    if server_name == "sumneko_lua" then
      lsp_cfg["settings"] = {
        Lua = {
          runtime = { version = 'LuaJIT' },
          diagnostics = { globals = { "vim" } },
          completion = { enable = true, callSnippet = "Replace" },
          telemetry = { enable = false },
          workspase = { library = vim.api.nvim_get_runtime_file("", true) }
        }
      }
    elseif server_name == "pyright" then
      lsp_cfg["settings"] = {
        python = { analysis = {
          autoSearchPaths = true,
          diagnosticMode = "workspace",
          -- NOTE: 以下两行可以避免type-stubs所引起的问题
          typeCheckingMode = 'off',
          useLibraryCodeForTypes = true
        }}
      }

    end
    require("lspconfig")[server_name].setup(lsp_cfg);
  end,
  -- 下面提供的是本身lsp之外的配置，不要再次setup lsp-config，因为这意味着配置了两边
  -- Next, you can provide a dedicated handler for specific servers.
  -- For example, a handler override for the `rust_analyzer`:
  -- ["rust_analyzer"] = function ()
  --     require("rust-tools").setup {}
  -- end
}
