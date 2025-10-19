return {
  "xiyaowong/transparent.nvim",
  config = function()
    require("transparent").setup({
      groups = { -- tabla de grupos de highlight
        'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
        'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
        'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
        'SignColumn', 'CursorLine', 'CursorLineNr', 'StatusLine', 'StatusLineNC',
        'EndOfBuffer',
      },
      extra_groups = {}, -- grupos adicionales que quieras transparentar
      exclude_groups = {
		'TelescopePromptNormal',
        'TelescopePromptBorder',
						}, -- grupos a excluir
    })
    
    -- Habilitar transparente
    require("transparent").toggle(true)
  end
}
