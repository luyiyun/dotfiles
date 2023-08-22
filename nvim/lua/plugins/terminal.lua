return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		-- event = "VeryLazy",
		keys = {
			{ "<leader>uh", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "open a horizontal terminal" },
			{ "<leader>uv", "<cmd>ToggleTerm direction=vertical<cr>", desc = "open a vertical terminal" },
			{ "<leader>uf", "<cmd>ToggleTerm direction=float<cr>", desc = "open a float terminal" },
			{ "<leader>ut", "<cmd>ToggleTerm direction=tab<cr>", desc = "open a tab terminal" },
			{ "<C-\\>", "<cmd>ToggleTerm direction=float<cr>", desc = "open a float terminal" },
		},
		config = function()
			local os = osinfo()
			if os == "WIN" then
				-- 如果是windows，则需要进行如下配置(powershell)
				local powershell_options = {
					shell = vim.fn.executable("pwsh") == 1 and "pwsh" or "powershell",
					shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;",
					shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait",
					shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode",
					shellquote = "",
					shellxquote = "",
				}
				for option, value in pairs(powershell_options) do
					vim.opt[option] = value
				end
			end

			function _G.set_terminal_keymaps()
				local opts = { buffer = 0 }
				vim.keymap.set("t", "<C-\\>", [[<C-\><C-N><cmd>ToggleTerm<cr>]], opts)
				vim.keymap.set("t", "<esc>", [[<C-\><C-N>]], opts)
				-- vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
				vim.keymap.set("t", "<C-h>", [[<Cmd>wincmh<CR>]], opts)
				vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
				vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
				vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
			end

			-- -- if you only want these mappings for toggle term use term://*toggleterm#* instead
			vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

			require("toggleterm").setup({})
		end,
	},
}
