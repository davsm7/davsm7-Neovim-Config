-- keymaps.lua - Configuración de atajos LSP sin warnings

local M = {}

-- Cache de keymaps
M._keys = nil

-- Obtener la lista de keymaps LSP
function M.get()
	if M._keys then
		return M._keys
	end

	M._keys = {
		{ "<leader>cl", "<cmd>LspInfo<cr>", desc = "Lsp Info" },
		{ "gd", vim.lsp.buf.definition, desc = "Goto Definition", has = "definition" },
		{ "gr", vim.lsp.buf.references, desc = "References", nowait = true },
		{ "gI", vim.lsp.buf.implementation, desc = "Goto Implementation" },
		{ "gy", vim.lsp.buf.type_definition, desc = "Goto T[y]pe Definition" },
		{ "gD", vim.lsp.buf.declaration, desc = "Goto Declaration" },
		{ "K", vim.lsp.buf.hover, desc = "Hover" },
		{ "gK", vim.lsp.buf.signature_help, desc = "Signature Help", has = "signatureHelp" },
		{ "<c-k>", vim.lsp.buf.signature_help, mode = "i", desc = "Signature Help", has = "signatureHelp" },
		{ "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" }, has = "codeAction" },
		{ "<leader>cr", vim.lsp.buf.rename, desc = "Rename", has = "rename" },
		{ "[d", vim.diagnostic.goto_prev, desc = "Previous Diagnostic" },
		{ "]d", vim.diagnostic.goto_next, desc = "Next Diagnostic" },
		{ "<leader>d", vim.diagnostic.open_float, desc = "Line Diagnostics" },
		{
			"<leader>f",
			function()
				vim.lsp.buf.format({ async = true })
			end,
			desc = "Format Document",
		},
	}

	return M._keys
end

-- Verificar si el LSP soporta un método
function M.has(buffer, method)
	if type(method) == "table" then
		for _, m in ipairs(method) do
			if M.has(buffer, m) then
				return true
			end
		end
		return false
	end

	method = method:find("/") and method or "textDocument/" .. method
	local clients = vim.lsp.get_clients({ bufnr = buffer })

	for _, client in ipairs(clients) do
		if client.supports_method and client.supports_method(method) then
			return true
		end
	end

	return false
end

-- Aplicar keymaps cuando se adjunta el LSP
function M.on_attach(_, buffer)
	local keymaps = M.get()

	for _, keys in pairs(keymaps) do
		local has = not keys.has or M.has(buffer, keys.has)
		local cond = not (keys.cond == false or ((type(keys.cond) == "function") and not keys.cond()))

		if has and cond then
			local opts = {
				desc = keys.desc,
				silent = keys.silent ~= false,
				buffer = buffer,
				nowait = keys.nowait,
			}

			local mode = keys.mode or "n"
			local lhs = keys[1]
			local rhs = keys[2]

			vim.keymap.set(mode, lhs, rhs, opts)
		end
	end
end

return M
