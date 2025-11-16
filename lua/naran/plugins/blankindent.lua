-- Ejemplo de configuración para ~/.config/nvim/lua/plugins/indent-blankline.lua
return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	opts = {
		indent = {
			-- Define tus propios colores para las guías
			highlight = { "SpecialKey" }, -- Usa el grupo de color de los comentarios
		},
		scope = {
			enabled = true,
			show_start = false, -- Oculta la línea de inicio del ámbito
		},
	},
}
