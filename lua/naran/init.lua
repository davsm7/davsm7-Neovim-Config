vim.g.mapleader = " "

require("naran.lazy")

require("naran.core.options")
--Scripts
require("naran.core.script.numbertoggle").setup()
require("naran.core.script.markBuffer")
require("naran.core.script.autoSave")
require("naran.core.keymaps")
-- require("naran.core.autocmds")
require("naran.plugins.lsp.formatter")
require("naran.plugins.lsp.keymaps")

local local_config = vim.fn.stdpath("config") .. "/lua/local.lua"
if vim.fn.filereadable(local_config) == 1 then
	dofile(local_config)
end
