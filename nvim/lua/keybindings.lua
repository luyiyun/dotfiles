-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │             _              _     _           _ _                             │
-- │            | | _____ _   _| |__ (_)_ __   __| (_)_ __   __ _ ___             │
-- │            | |/ / _ \ | | | '_ \| | '_ \ / _` | | '_ \ / _` / __|            │
-- │            |   <  __/ |_| | |_) | | | | | (_| | | | | | (_| \__ \            │
-- │            |_|\_\___|\__, |_.__/|_|_| |_|\__,_|_|_| |_|\__, |___/            │
-- │                   |___/                             |___/                    │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
---@diagnostic disable


-- -- ╭──────────────────────────────────────────────────────────────────────────────╮
-- -- │                               ufo 缩进美化插件                               │
-- -- ╰──────────────────────────────────────────────────────────────────────────────╯
-- keybindings.ufoKeys = function(ufo)
--   local previewFold = function()
--     local winid = ufo.peekFoldedLinesUnderCursor()
--     if not winid then
--       vim.lsp.buf.hover();
--     end
--   end;
--   wk.register({
--     ["zj"] = {
--       ufo.goNextClosedFold,
--       "next closed fold[ufo]",
--     },
--     ["zk"] = {
--       ufo.goPreviousClosedFold,
--       "prev closed fold[ufo]",
--     },
--     ["zJ"] = {
--       function()
--         ufo.goNextClosedFold();
--         ufo.peekFoldedLinesUnderCursor();
--       end,
--       "preview next closed fold[ufo]",
--     },
--     ["zK"] = {
--       function()
--         ufo.goPreviousClosedFold();
--         ufo.peekFoldedLinesUnderCursor();
--       end,
--       "preview prev closed fold[ufo]",
--     },
--     ["zR"] = {
--       ufo.openAllFolds,
--       "open all folds[ufo]",
--     },
--     ["zM"] = {
--       ufo.closeAllFolds,
--       "close all folds[ufo]",
--     },
--     ["zr"] = {
--       ufo.openFoldsExceptKinds,
--       "open more folds[ufo]",
--     },
--     ["zm"] = {
--       ufo.closeFoldsWith,
--       "close more folds[ufo]",
--     },
--     ["zp"] = {
--       previewFold,
--       "preview fold content[ufo]",
--     }
--   })
-- end
--
-- -- ╭──────────────────────────────────────────────────────────────────────────────╮
-- -- │                                  格式化代码                                  │
-- -- ╰──────────────────────────────────────────────────────────────────────────────╯
-- keybindings.formatterKeys = function(format)
--   wk.register({
--     ["<leader>ff"] = {
--       format,
--       "document format[formatter]",
--     }
--   })
-- end
--
-- -- ╭──────────────────────────────────────────────────────────────────────────────╮
-- -- │                                 特殊块级注释                                 │
-- -- ╰──────────────────────────────────────────────────────────────────────────────╯
-- keybindings.commentBoxKeys = function()
--   local mappings = {
--     ["<leader>cb"] = {
--       name = "+CommentBox",
--       l = {
--         [[<cmd>CBcatalog<CR>]],
--         "preview lines and boxes",
--       },
--     },
--     ["<leader>cbb"] = {
--       [[<cmd>CBlbox<CR>]],
--       "text:left length:auto",
--     },
--     ["<leader>cb1"] = {
--       [[<cmd>CBcbox<CR>]],
--       "text:center length:fixed",
--     },
--     ["<leader>cb2"] = {
--       [[<cmd>CBacbox<CR>]],
--       "text:center length:auto",
--     },
--   };
--   wk.register(mappings);
--   wk.register(mappings, { mode = "v", noremap = false, silent = true })
-- end
--
-- -- ╭──────────────────────────────────────────────────────────────────────────────╮
-- -- │                                 预览markdown                                 │
-- -- ╰──────────────────────────────────────────────────────────────────────────────╯
-- keybindings.markdownPreviewKeys = function()
--   wk.register({
--     ["<leader>Mp"] = {
--       "<cmd>MarkdownPreview<CR>",
--       "start preview markdown server[markdown-preview]",
--     },
--     ["<leader>MP"] = {
--       "<cmd>MarkdownPreviewStop<CR>",
--       "stop preview markdown server[markdown-preview]",
--     }
--   })
-- end
--
--
-- -- ╭──────────────────────────────────────────────────────────────────────────────╮
-- -- │                               切换主题                                       │
-- -- ╰──────────────────────────────────────────────────────────────────────────────╯
-- keybindings.onedarkKeys = function()
--   wk.register({
--     ["<leader>Tc"] = {
--       "<cmd>lua require('onedark').toggle()<CR>",
--       "toggle colorscheme[onedark]"
--     },
--   })
-- end
--
-- keybindings.base16Keys = function(setColorScheme)
--   wk.register({
--     ["<leader>Tc"] = {
--       function()
--         setColorScheme();
--       end,
--       "toggle colorscheme[base16]"
--     }
--   })
-- end
--
-- -- ╭──────────────────────────────────────────────────────────────────────────────╮
-- -- │                                   书签管理                                   │
-- -- ╰──────────────────────────────────────────────────────────────────────────────╯
-- keybindings.bookmarkKeys = function()
--   wk.register({
--     ["<F3>"] = {
--       "<Plug>BookmarkToggle<CR>",
--       "toggle bookmark[vim-bookmark]",
--     },
--     ["<leader>Bm"] = {
--       "<Plug>BookmarkToggle<CR>",
--       "toggle bookmark[vim-bookmark]",
--     },
--     ["<leader>Bp"] = {
--       "<Plug>BookmarkPrev<CR>",
--       "jump to next bookmark[vim-bookmark]",
--     },
--     ["<leader>Bn"] = {
--       "<Plug>BookmarkNext<CR>",
--       "jump to previous bookmark[vim-bookmark]",
--     },
--   });
-- end
--
-- -- ╭──────────────────────────────────────────────────────────────────────────────╮
-- -- │                                     注释                                     │
-- -- ╰──────────────────────────────────────────────────────────────────────────────╯
-- keybindings.kommentaryKeys = function()
--   -- nnoremap("<C-\\>", "<Plug>kommentary_line_default")
--   -- vnoremap("<C-\\>", "<Plug>kommentary_visual_default<C-c>gv-gv")
--   wk.register({
--     ["<C-\\>"] = {
--       "<Plug>kommentary_line_default",
--       "toggle comment[kommentary]",
--     },
--     ["<leader>;"] = {
--       "<Plug>kommentary_line_default",
--       "comment current line[kommentary]"
--     },
--     ["<leader>cl"] = {
--       "<Plug>kommentary_line_default",
--       "comment current line[kommentary]"
--     },
--   })
--   wk.register({
--     ["<C-\\>"] = {
--       "<Plug>kommentary_visual_default<C-c>gv-gv",
--       "toggle comment in selection[kommentary]",
--     },
--     ["<leader>cL"] = {
--       "<Plug>kommentary_visual_default<C-c>gv-gv",
--       "comment multi lines[kommentary]"
--     },
--   }, { mode = "v", silent = true, noremap = true })
-- end
--
-- -- ╭──────────────────────────────────────────────────────────────────────────────╮
-- -- │                                align 代码对齐                                │
-- -- ╰──────────────────────────────────────────────────────────────────────────────╯
-- keybindings.alignKeys = function(align)
--   local options = { noremap = true, silent = true };
--   vim.keymap.set("n", "gaw", function()
--     align.operator(align.align_to_string, {
--       is_pattern = false,
--       reverse    = true,
--       preview    = false
--     })
--   end, options);
--   vim.keymap.set("n", "gaa", function()
--     align.operator(align.align_to_char, {
--       is_pattern = false,
--       reverse    = true,
--       preview    = false
--     })
--   end, options);
--   wk.register({
--     ["<leader>aa"] = {
--       "<cmd>lua require('align').align_to_string(false,true,false)<CR>",
--       "align by string[align]",
--     },
--     ["<leader>aA"] = {
--       "<cmd>lua require('align').align_to_char(1,true,false)<CR>",
--       "align by char[align]",
--     },
--     ["<leader>ap"] = {
--       "<cmd>lua require('align').align_to_string(false,true,true)<CR>",
--       "align by string(preview)[align]",
--     },
--     ["<leader>ar"] = {
--       "<cmd>lua require('align').align_to_string(true,true,true)<CR>",
--       "align by string or pattern(preview)[align]",
--     },
--   }, { mode = "v" })
-- end
--
-- -- ╭──────────────────────────────────────────────────────────────────────────────╮
-- -- │                               formatter 格式化                               │
-- -- ╰──────────────────────────────────────────────────────────────────────────────╯
-- keybindings.gitsignsKeys = function()
--   wk.register({
--     ["<leader>g"] = {
--       ["f"] = {
--         "<cmd>Gitsigns refresh<CR>",
--         "refresh gitsigns[gitsigns]",
--       },
--       ["u"] = {
--         "<cmd>Gitsigns undo_stage_hunk<CR>",
--         "undo current hunk[gitsigns]",
--       },
--       ["r"] = {
--         "<cmd>Gitsigns reset_hunk<CR>",
--         "reset current hunk[gitsigns]",
--       },
--       ["R"] = {
--         "<cmd>Gitsigns reset_buffer<CR>",
--         "reset buffer all hunk[gitsigns]",
--       },
--       ["s"] = {
--         "<cmd>Gitsigns stage_hunk<CR>",
--         "stage current hunk[gitsigns]",
--       },
--       ["S"] = {
--         "<cmd>Gitsigns stage_buffer<CR>",
--         "stage buffer all hunk[gitsigns]",
--       },
--       ["d"] = {
--         "<cmd>Gitsigns diffthis<CR>",
--         "diff hunks[gitsigns]",
--       },
--       ["j"] = {
--         "<cmd>Gitsigns next_hunk<CR>",
--         "next hunk[gitsigns]",
--       },
--       ["k"] = {
--         "<cmd>Gitsigns prev_hunk<CR>",
--         "previous hunk[gitsigns]",
--       },
--     },
--     ["<leader>jc"] = {
--       "<cmd>Gitsigns prev_hunk<CR>",
--       "jump to previous change[gitsigns]",
--     },
--     ["<leader>jC"] = {
--       "<cmd>Gitsigns prev_hunk<CR>",
--       "jump to next change[gitsigns]",
--     },
--   })
-- end
--
-- -- ╭──────────────────────────────────────────────────────────────────────────────╮
-- -- │                                 hop 快速移动                                 │
-- -- ╰──────────────────────────────────────────────────────────────────────────────╯
-- keybindings.hopKeys = function()
--   -- 搜索字符
--   nnoremap("s", "<cmd>HopChar1<CR>");
--
--   -- 当前行内搜索字符: f向后搜索, F向前
--   nnoremap("f", "<cmd>HopChar1CurrentLineAC<CR>");
--   nnoremap("F", "<cmd>HopChar1CurrentLineBC<CR>");
--
--   -- 在当前文件中搜索单词
--   wk.register({
--     ["<leader>jj"] = {
--       "<cmd>HopChar1<CR>",
--       "jump to character[hop]",
--     },
--     ["<leader>jl"] = {
--       "<cmd>HopLine<CR>",
--       "jump to line[hop]",
--     },
--     ["<leader>jw"] = {
--       "<cmd>HopWord<CR>",
--       "jump to word[hop]",
--     },
--   });
-- end
--
-- -- ╭──────────────────────────────────────────────────────────────────────────────╮
-- -- │                          nvim-spectre 搜索替换增强                           │
-- -- ╰──────────────────────────────────────────────────────────────────────────────╯
-- keybindings.spectreKeys = function()
--   -- 在当前文件中搜索/替换
--   -- nnoremap("<leader>rr", "<cmd>lua require('spectre').open_file_search()<CR>")
--
--   -- 打开全局搜索/替换
--   -- nnoremap("<leader>rR", "<cmd>lua require('spectre').open()<CR>")
--
--   -- 选中模式下, 在所有文件中搜索: 被选中单词
--   -- vnoremap("<leader>rr", "<esc>:lua require('spectre').open_visual({select_word=true})<CR>")
--
--   wk.register({
--     ["<leader>rr"] = {
--       "<cmd>lua require('spectre').open_file_search()<CR>",
--       "search/replace in buffer[spectre]",
--     },
--     ["<leader>sF"] = {
--       "<cmd>lua require('spectre').open_file_search()<CR>",
--       "search/replace in buffer[spectre]",
--     },
--     ["<leader>rR"] = {
--       "<cmd>lua require('spectre').open()<CR>",
--       "search/replace in project[spectre]",
--     }
--   })
--
--   wk.register({
--     ["<leader>rr"] = {
--       "<esc>:lua require('spectre').open_visual({select_word=true})<CR>",
--       "search/replace selection in buffer[spectre]",
--     },
--     ["<leader>sR"] = {
--       "<esc>:lua require('spectre').open_visual({select_word=true})<CR>",
--       "search/replace selection in buffer[spectre]",
--     }
--   }, { mode = "v" })
--
--   return {
--     ["toggle_line"] = {
--       -- 切换当前行的状态
--       map = "dd",
--       cmd = "<cmd>lua require('spectre').toggle_line()<CR>",
--       desc = "toggle current item",
--     },
--     ["enter_file"] = {
--       -- 进入搜索到结果所在的文件
--       map = "<cr>",
--       cmd = "<cmd>lua require('spectre.actions').select_entry()<CR>",
--       desc = "goto current file",
--     },
--     ["run_current_replace"] = {
--       -- 替换当前行
--       map = "<leader>rc",
--       cmd = "<cmd>lua require('spectre.actions').run_current_replace()<CR>",
--       desc = "replace current line",
--     },
--     ["run_replace"] = {
--       -- 替换所有
--       map = "<leader>ra",
--       cmd = "<cmd>lua require('spectre.actions').run_replace()<CR>",
--       desc = "replace all",
--     },
--     ["change_view_mode"] = {
--       -- 切换是否替换结果视觉
--       map = "<leader>rv",
--       cmd = "<cmd>lua require('spectre').change_view()<CR>",
--       desc = "change result view mode",
--     },
--     ["toggle_ignore_case"] = {
--       -- 忽略大小写切换
--       map = "<leader>ri",
--       cmd = "<cmd>lua require('spectre').change_options('ignore-case')<CR>",
--       desc = "toggle ignore case",
--     },
--     ["show_option_menu"] = {
--       -- 显示菜单
--       map = "<leader>ro",
--       cmd = "<cmd>lua require('spectre').show_options()<CR>",
--       desc = "show option",
--     },
--   }
-- end
--
-- -- ╭──────────────────────────────────────────────────────────────────────────────╮
-- -- │                    vifm 终端管理文件器(功能和rnvimr一样)                     │
-- -- ╰──────────────────────────────────────────────────────────────────────────────╯
-- keybindings.vifmKeys = function()
--   wk.register({
--     ["<leader>ov"] = {
--       "<cmd>Vifm<CR>",
--       "open vifm[vifm]"
--     }
--   });
-- end
--
--
-- -- ╭──────────────────────────────────────────────────────────────────────────────╮
-- -- │                           session管理工具                                    │
-- -- ╰──────────────────────────────────────────────────────────────────────────────╯
-- keybindings.sessionManagerKeys = function()
--   -- 在退出编辑器之前 & 自动保存当前 session 状态
--   wk.register({
--     ["<leader>pr"] = {
--       "<cmd>SessionManager load_current_dir_session<CR>",
--       "load last session[session-manager]",
--     },
--     ["<leader>pl"] = {
--       "<cmd>SessionManager load_session<CR>",
--       "switch session[session-manager]",
--     },
--     ["<leader>pp"] = {
--       "<cmd>SessionManager load_session<CR>",
--       "switch session[session-manager]",
--     },
--     ["<leader>pd"] = {
--       "<cmd>SessionManager delete_session<CR>",
--       "delete sessions[session-manager]",
--     },
--     ["<leader>ps"] = {
--       "<cmd>SessionManager save_current_session<CR>",
--       "save sessions[session-manager]",
--     },
--   })
-- end
--
-- -- ╭──────────────────────────────────────────────────────────────────────────────╮
-- -- │                              telescope 搜索文件                              │
-- -- ╰──────────────────────────────────────────────────────────────────────────────╯
-- keybindings.telescopeKeys = function(builtin, actions)
--   -- nnoremap("<C-p>", "<cmd>Telescope find_files prompt_prefix=[files]<CR>")
--   -- nnoremap("<leader>fb", "<cmd>Telescope buffers prompt_prefix=[buffers]<CR>")
--   -- nnoremap("<leader>fs", "<cmd>Telescope live_grep prompt_prefix=[string]<CR>")
--   -- nnoremap("<leader>fh", "<cmd>Telescope help_tags prompt_prefix=[telescopeHelpTags]<CR>")
--
--   wk.register({
--     ["<C-p>"] = {
--       "<cmd>Telescope find_files<CR>",
--       "search files[telescope]"
--     },
--     ["<leader><leader>"] = {
--       "<cmd>Telescope commands<CR>",
--       "search commands[telescope]"
--     },
--     ["<leader>/"] = {
--       "<cmd>Telescope live_grep<CR>",
--       "search in project[telescope]"
--     },
--     ["<leader>?"] = {
--       "<cmd>Telescope keymaps<CR>",
--       "search keymaps[telescope]"
--     },
--     ["<leader>bs"] = {
--       "<cmd>Telescope buffers<CR>",
--       "search buffers[telescope]"
--     },
--     ["<leader>sf"] = {
--       "<cmd>Telescope current_buffer_fuzzy_find<CR>",
--       "fuzzy search[telescope]"
--     },
--     ["<leader>ot"] = {
--       "<cmd>Telescope vim_bookmarks all<CR>",
--       "open TODO view[telescope]",
--     },
--     ["<leader>pf"] = {
--       "<cmd>Telescope find_files<CR>",
--       "find file in project[telescope]",
--     },
--     ["<leader>sp"] = {
--       "<cmd>Telescope live_grep<CR>",
--       "search string in project[telescope]",
--     },
--     ["<leader>sb"] = {
--       "<cmd>Telescope buffers<CR>",
--       "search buffers[telescope]",
--     },
--     ["<leader>st"] = {
--       "<cmd>TodoTelescope<CR>",
--       "search todos[todo-comments]",
--     },
--     ["<leader>sH"] = {
--       "<cmd>Telescope highlights<CR>",
--       "search highlights[telescope]",
--     },
--     ["<leader>Bo"] = {
--       "<cmd>Telescope vim_bookmarks all<CR>",
--       "open bookmarks explorer[telescope]",
--     },
--     ["<leader>Bb"] = {
--       "<cmd>Telescope vim_bookmarks all<CR>",
--       "open bookmarks explorer[telescope]",
--     },
--     ["<leader>BB"] = {
--       "<cmd>Telescope vim_bookmarks all<CR>",
--       "open bookmarks explorer[telescope]",
--     },
--   })
--
--   wk.register({
--     ["<leader>sp"] = {
--       function()
--         builtin.current_buffer_fuzzy_find({
--           default_text  = getVisualSelection(),
--           prompt_prefix = "[fuzzy]"
--         });
--       end,
--       "search string in buffer with seclection[telescope]",
--     },
--     ["<leader>sP"] = {
--       function()
--         builtin.live_grep({
--           default_text  = getVisualSelection(),
--           prompt_prefix = "[string]"
--         });
--       end,
--       "search string in workspace with seclection[telescope]",
--     },
--   }, { mode = "v", silent = true, noremap = true });
--
--   return {
--     i = {
--       -- 在显示 telescope 输入框时, insert 模式的时候
--       ["<C-j>"] = actions.move_selection_next,
--       ["<C-k>"] = actions.move_selection_previous,
--       ["<C-n>"] = actions.cycle_history_next,
--       ["<C-p>"] = actions.cycle_history_prev,
--     },
--   }
-- end
--
-- -- ╭──────────────────────────────────────────────────────────────────────────────╮
-- -- │                          ctrl + x : 打开/关闭命令行                          │
-- -- ╰──────────────────────────────────────────────────────────────────────────────╯
-- keybindings.toggletermKeys = function(plugins)
--   wk.register({
--     ["<C-g>"] = {
--       function()
--         plugins.lazygit():toggle();
--       end,
--       "toggle lazygit[toggleterm]"
--     },
--     ["<C-n>"] = {
--       function()
--         plugins.vifm():toggle();
--       end,
--       "toggle vifm[toggleterm]"
--     },
--     ["<M-t>"] = {
--       "<cmd>call SilentOpenApp('kitty')<CR>",
--       "open kitty"
--     },
--   });
--
--   return "<C-x>"; -- toggle terminal
-- end
--
-- -- ╭──────────────────────────────────────────────────────────────────────────────╮
-- -- │                                   dap 调试                                   │
-- -- ╰──────────────────────────────────────────────────────────────────────────────╯
-- keybindings.dapKeys = function()
--   -- TODO: 不全, 查阅: https://github.com/mfussenegger/nvim-dap 尽量和 vscode 保持一致
--   -- nnoremap("<F3>", "<cmd>lua require'dap'.toggle_breakpoint(); require'user.dap.dap-util'.store_breakpoints(true)<cr>");
--   -- 标记断点
--   -- nnoremap("<F4>", "<cmd>lua require'dap'.toggle_breakpoint()<CR>")
--
--   -- -- 开启调试
--   -- nnoremap("<F5>", "<cmd>lua require'dap'.continue()<CR>")
--
--   -- -- 步入
--   -- nnoremap("<F6>", "<cmd>lua require'dap'.step_into()<CR>")
--
--   -- -- 步出
--   -- nnoremap("<F7>", "<cmd>lua require'dap'.step_out()<CR>")
--
--   -- -- 结束当前函数
--   -- nnoremap("<F8>", "<cmd>lua require'dap'.step_over()<CR>")
--
--   -- -- 重启
--   -- nnoremap("<F9>", "<cmd>lua require'dap'.run_last()<CR>")
--
--   -- -- 终止调试
--   -- nnoremap("<F10>", "<cmd>lua require'dap'.terminate()<CR>")
--
--   -- 菜单
--   wk.register({
--     ["<F4>"] = {
--       "<cmd>lua require('dap').toggle_breakpoint()<CR>",
--       "toggle breakpoint(F4)[dap]"
--     },
--     ["<leader>db"] = {
--       "<cmd>lua require('dap').toggle_breakpoint()<CR>",
--       "toggle breakpoint(F4)[dap]"
--     },
--     ["<F5>"] = {
--       "<cmd>lua require('dap').continue()<CR>",
--       "continue debug(F5)[dap]"
--     },
--     ["<leader>dd"] = {
--       "<cmd>lua require('dap').continue()<CR>",
--       "continue debug(F5)[dap]"
--     },
--     ["<F6>"] = {
--       "<cmd>lua require('dap').step_into()<CR>",
--       "debug step in(F6)[dap]"
--     },
--     ["<leader>di"] = {
--       "<cmd>lua require('dap').step_into()<CR>",
--       "debug step in(F6)[dap]"
--     },
--     ["<F7>"] = {
--       "<cmd>lua require('dap').step_out()<CR>",
--       "debug step out(F7)[dap]"
--     },
--     ["<leader>do"] = {
--       "<cmd>lua require('dap').step_out()<CR>",
--       "debug step out(F7)[dap]"
--     },
--     ["<F8>"] = {
--       "<cmd>lua require('dap').step_over()<CR>",
--       "debug step over(F8)[dap]"
--     },
--     ["<leader>ds"] = {
--       "<cmd>lua require('dap').step_over()<CR>",
--       "debug step over(F8)[dap]"
--     },
--     ["<F9>"] = {
--       "<cmd>lua require('dap').run_last()<CR>",
--       "debug step out(F9)[dap]"
--     },
--     ["<leader>dR"] = {
--       "<cmd>lua require('dap').run_last()<CR>",
--       "debug step out(F9)[dap]"
--     },
--     ["<F10>"] = {
--       "<cmd>lua require('dap').terminate()<CR>",
--       "stop debug(F10)[dap]"
--     },
--     ["<leader>dS"] = {
--       "<cmd>lua require('dap').terminate()<CR>",
--       "stop debug(F10)[dap]"
--     }
--   })
-- end
--
-- -- ╭──────────────────────────────────────────────────────────────────────────────╮
-- -- │                                    dapUI                                     │
-- -- ╰──────────────────────────────────────────────────────────────────────────────╯
-- keybindings.dapUIKeys = function()
--   return {
--     mappings = {
--       expand = { "<CR>" },
--       open   = "o",
--       remove = "d",
--       edit   = "e",
--       repl   = "r",
--       toggle = "t",
--     },
--     floatingMappings = {
--       close = { "q", "<Esc>" },
--     },
--   }
-- end


-- return keybindings
