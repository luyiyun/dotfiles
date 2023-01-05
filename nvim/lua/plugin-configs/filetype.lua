local filetype = loadModule("filetype", "plugin-configs");
filetype.setup({
  overrides = {
    -- extensions = {
    --   -- Set the filetype of *.pn files to potion
    --   pn = "potion",
    -- },
    -- literal = {
    --     -- Set the filetype of files named "MyBackupFile" to lua
    --     MyBackupFile = "lua",
    -- },
    -- complex = {
    --     -- Set the filetype of any full filename matching the regex to gitconfig
    --     [".*git/config"] = "gitconfig", -- Included in the plugin
    -- },

    -- The same as the ones above except the keys map to functions
    function_extensions = {
        py = function()
          vim.opt_local.tabstop = 4;   -- NOTE:这里只能使用opt_local，不能使用bo
          vim.opt_local.softtabstop = 4;
          vim.opt_local.shiftwidth = 4;
          vim.opt_local.colorcolumn = "81";
          return "python";  -- NOTE:这里需要返回文件类型（字符串），不然无法工作
        end,
    },
    -- function_literal = {
    --     Brewfile = function()
    --         vim.cmd("syntax off")
    --     end,
    -- },
    -- function_complex = {
    --     ["*.math_notes/%w+"] = function()
    --         vim.cmd("iabbrev $ $$")
    --     end,
    -- },

    -- shebang = {
    --     -- Set the filetype of files with a dash shebang to sh
    --     dash = "sh",
    -- },
  },
})
