vim.g.mapleader = " "

require("naran.lazy")

require("naran.core.options")
-- require("naran.core.keymaps")
-- require("naran.core.autocmds")


local local_config = vim.fn.stdpath("config") .. "/lua/local.lua"
if vim.fn.filereadable(local_config) == 1 then
  dofile(local_config)
end

