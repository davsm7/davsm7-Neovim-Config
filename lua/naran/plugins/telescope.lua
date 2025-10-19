return {

  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",  -- Carga perezosa al usar el comando
  keys = {  -- Carga perezosa al usar atajos
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
  },
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
  -- Configuración básica de Telescope
  require("telescope").setup({
    defaults = {
      file_ignore_patterns = { "node_modules" },
      -- Otras configuraciones que quieras mantener
      layout_strategy = "vertical",
      layout_config = {
        vertical = { width = 0.9, height = 0.9 }
      },
    },
    pickers = {
      find_files = {
        hidden = true,
      },
    },
  })

  -- Hacer el fondo de Telescope transparente
  local transparent_hl_groups = {
    "TelescopeNormal",
    "TelescopeBorder",
    "TelescopePreviewNormal",
    "TelescopePreviewBorder",
    "TelescopeResultsNormal",
    "TelescopeResultsBorder",
  }

  for _, hl in ipairs(transparent_hl_groups) do
    vim.api.nvim_set_hl(0, hl, { bg = "none" })
    end

    end
}
