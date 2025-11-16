return {
	"catppuccin/nvim",
	name = "catppuccin",
	lazy = false,
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			flavour = "mocha",
			transparent_background = true,
			show_end_of_buffer = false, -- ← Esto soluciona las virgulillas oscuras [citation:1][citation:4]
			styles = {
				comments = { "italic" },
				conditionals = { "italic" },
				loops = {},
				functions = { "bold" },
				keywords = {},
				strings = { "bold" }, -- Estilo para strings (p.ej., "bold")
				variables = { "italic" }, -- ← Variables en itálica
				numbers = {},
				booleans = {},
				properties = {},
				types = {},
				operators = {},
			},
			integrations = {
				barbar = false,
				lualine = true,
				cmp = true,
				telescope = true,
				treesitter = true,
				gitsigns = true,
				indent_blankline = { -- ← Configuración correcta para indent-blankline [citation:7]
					enabled = true,
					scope_color = "SpecialKey", -- Usa el color del tema para el ámbito
					colored_indent_levels = false,
				},
			},
			custom_highlights = function(colors)
				return {
					EndOfBuffer = { fg = colors.surface0 }, -- Color tenue como el fondo
					-- O si quieres que sean casi invisibles:
					-- EndOfBuffer = { fg = colors.base }, -- Mismo color que el fondo

					-- Bonus: también arregla las líneas de indentación
					IblIndent = { fg = colors.surface0 },
					IblScope = { fg = colors.surface1 },
				}
			end,
		})

		vim.cmd.colorscheme("catppuccin")
	end,
}
