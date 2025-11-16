return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup({
      view = {
        width = 35,
        side = "left",
      },
      actions = {
        open_file = {
          quit_on_open = true,
        },
      },
      update_focused_file = {
        enable = true,
        update_root = true,
      },
      renderer = {
        group_empty = true,
      },
      filters = {
        dotfiles = false,
        custom = { "node_modules", ".git" },
      },
    })

    -- Atajo global: Ctrl + n para abrir/cerrar
    vim.keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>", { desc = "Toggle NvimTree" })

    local function set_root_and_cd()
      local tree_api = require("nvim-tree.api")
      local node = tree_api.tree.get_node_under_cursor() -- Use the new API function
      
      if node then
        local new_root
        if node.type == "directory" then
          new_root = node.absolute_path
        else
          -- If it's a file, use its parent directory
          new_root = vim.fn.fnamemodify(node.absolute_path, ":h")
        end
        
        -- Change the tree's root visually
        tree_api.tree.change_root(new_root)
        -- Change Neovim's current working directory
        vim.cmd("cd " .. vim.fn.fnameescape(new_root))
        
        -- Optional: Print a confirmation message
        print("Root changed to: " .. new_root)
      end
    end

    -- SOLUCIÓN 3: Función para abrir con aplicación externa en nvim-tree
    local function open_with_external_app()
      local tree_api = require("nvim-tree.api")
      local node = tree_api.tree.get_node_under_cursor()
      
      if node and node.absolute_path then
        local filename = node.absolute_path
        
        -- Verificar que el archivo existe
        if vim.fn.filereadable(filename) == 0 then
          print("Archivo no encontrado: " .. filename)
          return
        end
        
        -- Usar xdg-open
        vim.fn.jobstart({"xdg-open", filename}, {
          detach = true,
          on_exit = function(_, code)
            if code ~= 0 then
              vim.schedule(function()
                print("Error al abrir el archivo")
              end)
            end
          end
        })
        
        print("Abriendo: " .. filename)
      end
    end

    -- Mapear Ctrl+l en nvim-tree
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "NvimTree",
      callback = function()
        -- Mapping para cambiar directorio raíz
        vim.keymap.set("n", "<C-l>", set_root_and_cd, { 
          buffer = true, 
          desc = "Set current folder as root and cd" 
        })
        
        -- SOLUCIÓN 3: Mapping para abrir con aplicación externa
        vim.keymap.set("n", ";", open_with_external_app, {
          buffer = true,
          desc = "Abrir con aplicación externa"
        })
        
        -- Opcional: también con leader + ;
        vim.keymap.set("n", "<leader>;", open_with_external_app, {
          buffer = true,
          desc = "Abrir con aplicación externa"
        })
      end,
    })

    -- Abrir nvim-tree automáticamente si se inicia Neovim con un directorio
    local function open_nvim_tree()
      local argv = vim.fn.argv()
      if #argv == 1 and vim.fn.isdirectory(argv[1]) == 1 then
        require("nvim-tree.api").tree.open()
        vim.cmd("cd " .. argv[1])
      end
    end

    vim.api.nvim_create_autocmd("VimEnter", {
      callback = open_nvim_tree,
    })
  end,
}
