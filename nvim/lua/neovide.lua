-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │ neovide 客户端配置                                                           │
-- │ docs: https://neovide.dev/configuration.html#configuration                   │
-- │ github: https://github.com/neovide/neovide                                   │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
-- 设置 neovide 选项
local neovide_settings = {
  -- neovide_transparency            = 0.5,   -- 透明度
  neovide_fullscreen              = false, -- 全屏打开
  neovide_remember_window_size    = true,  -- 记住之前的大小
  neovide_input_macos_alt_is_meta = true,  -- 将 meta 映射到 alt
  neovide_input_use_logo          = true,  -- macos only
  neovide_scale_factor            = 0.8,   -- 整体元素放大倍数
  neovide_cursor_animation_length = 0.05,     -- 光标拖尾持续时间，0表示取消特效
  neovide_cursor_vfx_mode         = "",  -- 光标粒子特效，""表示取消
}

for k, v in pairs(neovide_settings) do
  vim.g[k] = v
end

-- 设置字体
-- setFontSize("Hack Nerd Font Mono", 14)
setFontSize("FiraCode Nerd Font Mono", 10)

-- 设置快捷键
-- local keyset = vim.api.nvim_set_keymap;
-- local options = { noremap = true, silent = true };
-- keyset('', '<D-v>', '+p<CR>',  options);
-- keyset('!', '<D-v>', '<C-R>+', options);
-- keyset('t', '<D-v>', '<C-R>+', options);
-- keyset('v', '<D-v>', '<C-R>+', options);
-- keyset('c', '<D-v>', '<C-R>+', options);
