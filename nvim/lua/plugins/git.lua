return {
  -- ------------------------
  -- -在vim中直接进行git操作-
  -- ------------------------
  {"tpope/vim-fugitive", cmd="Git"},

  -- ---------
  -- -整合git-
  -- ---------
  {
    "lewis6991/gitsigns.nvim",
    config = function() require("plugin-configs.gitsigns") end
  },
}
