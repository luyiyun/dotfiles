return {
  -- ------------------------
  -- -在vim中直接进行git操作-
  -- ------------------------
  {"tpope/vim-fugitive", cmd="Git", event="VeryLazy"},

  -- ---------
  -- -整合git-
  -- ---------
  {
    "lewis6991/gitsigns.nvim",
    event="VeryLazy",
    -- config = function() require("plugin-configs.gitsigns") end
    opts = {
      on_attach = function(bufnr)
        local gss = package.loaded.gitsigns
        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']h', function()
          if vim.wo.diff then return ']h' end
          vim.schedule(function() gss.next_hunk() end)
          return '<Ignore>'
        end, {expr=true})

        map('n', '[h', function()
          if vim.wo.diff then return '[h' end
          vim.schedule(function() gss.prev_hunk() end)
          return '<Ignore>'
        end, {expr=true})
        --
        -- -- Actions
        -- hunks指相对于当前的代码库（暂存库），文件中所做出的修改
        -- stage指将修改的代码提交到暂存库，可以只提交单个hunk
        -- 全局的stage、commit、push可以交给fugitive来做
        --
        map({'n', 'v'}, '<leader>gs', ':Gitsigns stage_hunk<CR>')
        map({'n', 'v'}, '<leader>gu', ':Gitsigns undo_stage_hunk<CR>')
        map({'n', 'v'}, '<leader>gr', ':Gitsigns reset_hunk<CR>')
        map('n', '<leader>gp', gss.preview_hunk)
        -- map('n', '<leader>hS', gs.stage_buffer)
        -- map('n', '<leader>hu', gs.undo_stage_hunk)
        -- map('n', '<leader>hR', gs.reset_buffer)
        -- map('n', '<leader>hb', function() gs.blame_line{full=true} end)
        -- map('n', '<leader>tb', gs.toggle_current_line_blame)
        -- map('n', '<leader>hd', gs.diffthis)
        -- map('n', '<leader>hD', function() gs.diffthis('~') end)
        -- map('n', '<leader>td', gs.toggle_deleted)
        --
        -- -- Text object
        -- map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
      end,
    }
  },
}
