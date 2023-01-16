-- you can configure Hop the way you like here; see :h hop-config
local hop = loadModule("hop", "plugin-configs")
local wk = loadModule("which-key", "plugin-configs")
-- local directions = require('hop.hint').HintDirection

wk.register({
  ["<leader>j"] = {"<cmd>HopWord<cr>", "Go to any word in the current buffer"}
})

hop.setup()
