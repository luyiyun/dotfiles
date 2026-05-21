return {
  {
    "luozhiya/fittencode.nvim",
    event = "InsertEnter",
    opts = {
      completion_mode = "inline",

      inline_completion = {
        enable = true,
        auto_triggering_completion = true,
        disable_completion_when_insert_enter = false,
      },

      -- 关键：关闭 FittenCode 默认快捷键，避免它抢 <Tab>
      use_default_keymaps = false,

      -- 改用 Ctrl-l 接受 Fitten inline completion
      keymaps = {
        inline = {
          inccmp = {
            inline_completion = "<A-\\>",
            accept_all = "<C-l>",
            accept_next_line = "<C-Down>",
            accept_next_word = "<C-Right>",
            revoke = { "<C-Left>", "<C-Up>" },
          },
        },
      },

      language_preference = {
        display_preference = "zh-cn",
        comment_preference = "zh-cn",
        commit_message_preference = "zh-cn",
      },
    },
  },
}
