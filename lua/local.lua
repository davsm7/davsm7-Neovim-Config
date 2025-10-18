-- ~/.config/nvim/lua/local.lua
local ok, _ = pcall(vim.cmd, "colorscheme ashen")
if not ok then
  vim.notify("Colorscheme 'ashen' not found", vim.log.levels.WARN)
end

