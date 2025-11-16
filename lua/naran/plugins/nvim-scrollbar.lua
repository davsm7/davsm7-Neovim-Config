return {
	"petertriho/nvim-scrollbar",
	dependencies = {
		"lewis6991/gitsigns.nvim",
		"kevinhwang91/nvim-hlslens",
	},
	config = function()
		require("scrollbar").setup({
			-- Puedes añadir opciones de configuración aquí
		})

		-- Integración opcional para resaltar búsquedas
		require("scrollbar.handlers.search").setup()
	end,
}
