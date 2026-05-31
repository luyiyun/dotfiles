return {
  {
    "quarto-dev/quarto-nvim",
    dependencies = {
      "quarto-dev/quarto-nvim",
      "jmbuhr/otter.nvim",
      "hrsh7th/nvim-cmp",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    dev = false,
    opts = {
      lspFeatures = {
        enabled = true,
        chunks = "curly",
      },
      codeRunner = {
        enabled = true,
        default_method = "slime",
      },
    },
  },
  {
    dir = "/Users/rong/Project/quarto-sync.nvim",
    ft = { "quarto", "markdown" },
    main = "quarto_sync",
    opts = {
      port = 18787,
      quarto_cmd = "quarto",
      open_browser = true,
      debounce_ms = 120,
    },
  },
}
