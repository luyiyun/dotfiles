return {
  -- {
  --   "iamcco/markdown-preview.nvim",
  --   cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  --   ft = { "markdown" },
  --   build = function() vim.fn["mkdp#util#install"]() end,
  --   keys = {
  --     { "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", desc = "Toggle markdown preview" },
  --   },
  --   config = function()
  --     vim.g.mkdp_open_to_the_world = 1
  --     vim.g.mkdp_open_ip = '127.0.0.1'
  --     vim.g.mkdp_port = '6419'
  --     vim.api.nvim_exec(
  --       [[
  --       function! g:EchoUrl(url)
  --           :echo a:url
  --       endfunction
  --       let g:mkdp_browserfunc = 'g:EchoUrl'
  --       ]], true
  --     )
  --     -- vim.g.mkdp_browser = 'firefox'
  --     -- vim.cmd([[do FileType]])
  --   end,
  -- },
  {
    "jbyuki/md-prev.nvim",
    keys = {
      { "<leader>mp", function () require("md-prev").start_server(6419) end, desc = "Toggle markdown preview" },
    },
  },
}
