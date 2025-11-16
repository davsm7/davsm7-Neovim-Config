local marked_buffers = {}
local current_index = 0

local function mark_buffer()
    local bufnr = vim.api.nvim_get_current_buf()
    local bufname = vim.fn.bufname(bufnr)
    
    -- Verificar si el buffer ya está marcado
    for i, marked_buf in ipairs(marked_buffers) do
        if marked_buf == bufnr then
            print("Buffer ya marcado: " .. bufname)
            return
        end
    end
    
    -- Agregar nuevo buffer marcado
    marked_buffers[#marked_buffers + 1] = bufnr
    print("✅ Buffer marcado: " .. bufname)
end

local function unmark_buffer()
    local bufnr = vim.api.nvim_get_current_buf()
    local bufname = vim.fn.bufname(bufnr)
    
    for i, marked_buf in ipairs(marked_buffers) do
        if marked_buf == bufnr then
            table.remove(marked_buffers, i)
            print("❌ Buffer desmarcado: " .. bufname)
            
            -- Ajustar el índice actual si es necesario
            if current_index >= i then
                current_index = math.max(0, current_index - 1)
            end
            return
        end
    end
    
    print("Buffer no estaba marcado: " .. bufname)
end

local function clear_all_marks()
    marked_buffers = {}
    current_index = 0
    print("🧹 Todos los buffers desmarcados")
end

local function navigate_buffers(direction)
    if #marked_buffers == 0 then
        print("❌ No hay buffers marcados")
        return
    end
    
    -- Calcular nuevo índice
    if direction == "next" then
        current_index = (current_index % #marked_buffers) + 1
    else -- "prev"
        current_index = current_index - 1
        if current_index < 1 then
            current_index = #marked_buffers
        end
    end
    
    -- Navegar al buffer
    local target_bufnr = marked_buffers[current_index]
    local bufname = vim.fn.bufname(target_bufnr)
    
    -- Verificar si el buffer aún existe
    if vim.api.nvim_buf_is_valid(target_bufnr) then
        vim.api.nvim_set_current_buf(target_bufnr)
        print("📁 " .. bufname .. " (" .. current_index .. "/" .. #marked_buffers .. ")")
    else
        -- Buffer ya no existe, removerlo de la lista
        table.remove(marked_buffers, current_index)
        print("⚠️  Buffer ya no existe, removiendo de la lista")
        navigate_buffers(direction) -- Intentar con el siguiente
    end
end

local function list_marked_buffers()
    if #marked_buffers == 0 then
        print("📋 No hay buffers marcados")
        return
    end
    
    print("📋 Buffers marcados:")
    for i, bufnr in ipairs(marked_buffers) do
        local indicator = (i == current_index) and "➤" or " "
        local bufname = vim.fn.bufname(bufnr)
        print(string.format("  %s [%d] %s", indicator, i, bufname))
    end
end

-- Atajos de teclado
vim.keymap.set('n', '<leader>m', mark_buffer, { desc = 'Marcar buffer para navegación rápida' })
vim.keymap.set('n', '<leader>M', unmark_buffer, { desc = 'Desmarcar buffer actual' })
vim.keymap.set('n', '<leader>mc', clear_all_marks, { desc = 'Limpiar todos los buffers marcados' })
vim.keymap.set('n', '<leader>ml', list_marked_buffers, { desc = 'Listar buffers marcados' })

-- Navegación entre buffers marcados
vim.keymap.set('n', '<leader>mn', function() navigate_buffers("next") end, { desc = 'Siguiente buffer marcado' })
vim.keymap.set('n', '<leader>mp', function() navigate_buffers("prev") end, { desc = 'Buffer marcado anterior' })

-- Navegación rápida con teclas direccionales (opcional)
vim.keymap.set('n', '<A-n>', function() navigate_buffers("next") end, { desc = 'Siguiente buffer marcado' })
vim.keymap.set('n', '<A-p>', function() navigate_buffers("prev") end, { desc = 'Buffer marcado anterior' })
