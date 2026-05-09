return {
  {
    "folke/persistence.nvim",
    keys = {
      -- 禁用 LazyVim 默认的 Select Session
      { "<leader>qS", false },

      -- 改成 <leader>fs
      {
        "<leader>fs",
        function()
          require("persistence").select()
        end,
        desc = "Select Session",
      },
    },
  },
}
