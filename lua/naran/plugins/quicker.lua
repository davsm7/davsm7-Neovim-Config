return {
	"stevearc/quicker.nvim",
	ft = "qf", -- solo cargar cuando se abra el buffer de quickfix
	opts = {
		edit = {
			enabled = true,
			autosave = "unmodified",
		},
		constrain_cursor = true,
		highlight = {
			treesitter = true,
			lsp = true,
			load_buffers = false,
		},
		keys = {
			{
				">",
				function()
					require("quicker").expand({ before = 2, after = 2, add_to_existing = true })
				end,
				desc = "Expand quickfix context",
			},
			{
				"<",
				function()
					require("quicker").collapse()
				end,
				desc = "Collapse quickfix context",
			},
		},
	},
	keys = {
		{
			"<leader>q",
			function()
				require("quicker").toggle()
			end,
			desc = "Toggle quickfix window",
		},
		{
			"<leader>l",
			function()
				require("quicker").toggle({ loclist = true })
			end,
			desc = "Toggle location list",
		},
	},
}
