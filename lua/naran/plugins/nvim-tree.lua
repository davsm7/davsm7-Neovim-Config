return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()

    require("nvim-tree").setup {
      -- Configuración fácil de recordar
      view = {
        width = 35, -- Ancho de la ventana
        side = "left", -- Lado izquierdo
      },
      actions = {
        open_file = {
          quit_on_open = false, -- Cerrar tree al abrir archivo
        },
      },
    }

    -- Atajo global fácil: Ctrl + n para abrir/cerrar
    vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>', { desc = 'Toggle NvimTree' })
  end,
}
