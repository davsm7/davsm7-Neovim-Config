-- Crea un grupo de autocomandos para evitar duplicados
local group = vim.api.nvim_create_augroup("Autosave", { clear = true })

-- Configura el guardado automático
vim.api.nvim_create_autocmd({ "BufLeave" }, {
	pattern = "*",
	command = "silent! wa",

})
