-- ~/.config/nvim/lua/plugins/motions.lua
return {
	-- Leap.nvim - movimiento principal
	{
		"ggandor/leap.nvim",
		keys = {
			{ "s", mode = { "n", "x", "o" }, desc = "Leap forward to" },
			{ "<leader>s", mode = { "n", "x", "o" }, desc = "Leap backward to" },
			{ "gs", mode = { "n", "x", "o" }, desc = "Leap from windows" },
		},
		config = function(_, opts)
			local leap = require("leap")

			leap.opts.case_sensitive = false
			leap.opts.safe_labels = {}

			-- Mapeo para buscar hacia adelante
			vim.keymap.set({ "n", "x" }, "s", function()
				leap.leap({
					target_windows = { vim.fn.win_getid() },
					opts = { direction = "forward" },
				})
			end)

			-- Mapeo para buscar hacia atrás (usando <leader>s en lugar de S)
			vim.keymap.set({ "n", "x" }, "<leader>s", function()
				leap.leap({
					target_windows = { vim.fn.win_getid() },
					opts = { direction = "backward" },
				})
			end)

			-- Mapeo para modo operador
			vim.keymap.set("o", "z", function()
				leap.leap({
					target_windows = { vim.fn.win_getid() },
					opts = { inclusive_op = true },
				})
			end)

			-- Mapeo para buscar entre ventanas
			vim.keymap.set({ "n", "x", "o" }, "gs", function()
				leap.leap({
					target_windows = vim.tbl_filter(function(win)
						return vim.api.nvim_win_get_config(win).focusable
					end, vim.api.nvim_list_wins()),
				})
			end)
		end,
	},

	-- Flit.nvim - mejora movimientos f/F/t/T
	{
		"ggandor/flit.nvim",
		dependencies = { "ggandor/leap.nvim" },
		opts = {
			labeled_modes = "nx",
			multiline = true,
		},
		keys = function()
			local ret = {}
			for _, key in ipairs({ "f", "F", "t", "T" }) do
				ret[#ret + 1] = { key, mode = { "n", "x", "o" } }
			end
			return ret
		end,
	},

	-- vim-repeat - para repetir con .
	{
		"tpope/vim-repeat",
		event = "VeryLazy",
	},
}
