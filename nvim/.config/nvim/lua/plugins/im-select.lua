return {
  {
    "keaising/im-select.nvim",
    event = "VeryLazy",
    config = function()
      require("im_select").setup({
        -- 离开 Insert / 进入命令行时切换到英文输入法
        -- 这里请改成你执行 macism 后得到的英文输入法 ID
        default_im_select = "com.apple.keylayout.ABC",

        -- macOS 推荐使用 macism
        default_command = "macism",

        -- 切到 Insert 之外的状态时使用英文
        set_default_events = {
          "InsertLeave",
          "CmdlineEnter",
        },

        -- 回到 Insert 时恢复之前 Insert 中使用的输入法
        set_previous_events = {
          "InsertEnter",
        },

        -- 异步切换，减少卡顿感
        async_switch_im = true,

        -- 没找到 macism 时给出提示
        keep_quiet_on_no_binary = false,
      })
    end,
  },
}
