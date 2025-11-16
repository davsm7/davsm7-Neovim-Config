return {
	"akinsho/toggleterm.nvim",
	version = "*",
	opts = {
		size = 15,
		open_mapping = [[<leader>ft]], -- Abrir/cerrar terminal con <leader>t
		hide_numbers = true,
		shade_filetypes = {},
		shade_terminals = true,
		shading_factor = 2,
		start_in_insert = true,
		persist_size = true,
		direction = "horizontal",
		close_on_exit = true,
		float_opts = {
			border = "curved",
			winblend = 0,
		},
	},
}
