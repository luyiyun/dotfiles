return {
  {
    "luozhiya/fittencode.nvim",
    event = "InsertEnter",
    opts = {
      -- completion_mode = "inline",
      -- inline_completion = {
      --   enable = true,
      --   auto_triggering_completion = true,
      --   disable_completion_when_insert_enter = false,
      -- },
      -- use_default_keymaps = false, -- 关键：避免 Fitten 自己再抢 Tab
    },
  },

  -- {
  --   "saghen/blink.cmp",
  --   opts = function(_, opts)
  --     opts.keymap = opts.keymap or {}
  --
  --     opts.keymap["<Tab>"] = {
  --       -- 1. 优先接受 Fitten inline completion
  --       function()
  --         local ok, fitten = pcall(require, "fittencode")
  --         if ok and fitten.has_completions and fitten.has_completions() then
  --           fitten.accept("all")
  --           return true
  --         end
  --         return false
  --       end,
  --
  --       -- 2. 没有 Fitten 建议时，恢复 LazyVim / blink 的 Tab 行为
  --       LazyVim.cmp.map({ "snippet_forward", "ai_nes", "ai_accept" }),
  --
  --       -- 3. 最后回退为普通 Tab
  --       "fallback",
  --     }
  --   end,
  -- },
}
