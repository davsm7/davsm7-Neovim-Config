--Formatear texto
vim.keymap.set("n", "<leader>fm", function()
	require("conform").format()
end, { desc = "Formatear texto" })

-- Navegación entre buffers
vim.keymap.set("n", "<leader>[", ":bprevious<CR>", { desc = "Buffer anterior" })
vim.keymap.set("n", "<leader>]", ":bnext<CR>", { desc = "Buffer siguiente" })
vim.keymap.set("n", "<leader>q", ":bdelete<CR>", { desc = "Cerrar buffer actual" })
