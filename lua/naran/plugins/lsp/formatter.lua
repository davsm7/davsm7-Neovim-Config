-- formatter.lua - Formateo condicional (solo si no hay errores)

-- Mason: gestor de herramientas
require("mason").setup()

-- Función para verificar si hay errores de diagnóstico
local function has_errors(bufnr)
	local diagnostics = vim.diagnostic.get(bufnr, { severity = vim.diagnostic.severity.ERROR })
	return #diagnostics > 0
end

-- Conform: formateador unificado
require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		javascript = { "prettier" },
		typescript = { "prettier" },
		json = { "prettier" },
		yaml = { "prettier" },
		markdown = { "prettier" },
		python = { "black" },
		html = { "prettier" },
		css = { "prettier" },
		sh = { "shfmt" },
		toml = { "taplo" },
		-- texto plano o tabulado
		text = { "expandtabs" },
		csv = { "column" },
		tsv = { "column" },
	},

	-- 🔧 Auto formatear al guardar SOLO si no hay errores
	format_on_save = function(bufnr)
		-- No formatear si hay errores
		if has_errors(bufnr) then
			vim.notify("⚠️  Formateo cancelado: hay errores en el código", vim.log.levels.WARN)
			return nil
		end

		-- Formatear si no hay errores
		return {
			lsp_fallback = true,
			timeout_ms = 500,
		}
	end,
})

-- Integrar instalación automática de formatters
require("mason-conform").setup({
	ensure_installed = {
		"prettier",
		"stylua",
		"black",
		"shfmt",
		"taplo",
	},
})

-- 🧰 Definir un formateador simple para tabulación
require("conform").formatters.expandtabs = {
	command = "expand", -- herramienta de GNU coreutils
	args = { "--tabs=4" },
	stdin = true,
}

-- 🧰 Usar 'column' para alinear tablas tipo CSV o TSV
require("conform").formatters.column = {
	command = "column",
	args = { "-t", "-s", "," }, -- separa por comas y alinea
	stdin = true,
}

-- 🎯 Keymap manual para formatear (ignorando errores si lo deseas)
vim.keymap.set("n", "<leader>fm", function()
	require("conform").format({
		lsp_fallback = true,
		async = true,
	})
end, { desc = "Format (forzar)" })

-- 🎯 Keymap para formatear solo si no hay errores
vim.keymap.set("n", "<leader>fs", function()
	if has_errors(0) then
		vim.notify("⚠️  No se puede formatear: hay errores en el código", vim.log.levels.WARN)
		return
	end

	require("conform").format({
		lsp_fallback = true,
		async = true,
	})
end, { desc = "Format (solo sin errores)" })
