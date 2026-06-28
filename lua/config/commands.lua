-- ~/.config/nvim/lua/config/commands.lua

vim.api.nvim_create_user_command(
    "SceneBuilder", -- El nombre del comando (Debe empezar obligatoriamente con Mayúscula)
    function()
        -- 1. Obtenemos la extensión del archivo actual
        local file_ext = vim.fn.expand("%:e")

        -- 2. Validamos que sea un archivo FXML
        if file_ext == "fxml" then
            local current_file = vim.fn.expand("%:p")

            -- Ejecutamos tu comando optimizado de forma asíncrona y desvinculada
            vim.fn.jobstart({ "/opt/scenebuilder/bin/SceneBuilder", current_file }, { detach = true })

            vim.notify("SceneBuilder lanzado para: " .. vim.fn.expand("%:t"), vim.log.levels.INFO)
        else
            -- Si no es FXML, mandamos un aviso limpio en la barra de estado
            vim.notify("Error: El archivo actual no es un formato .fxml", vim.log.levels.WARN)
        end
    end,
    { desc = "Abre el archivo FXML actual en SceneBuilder" } -- Descripción para el buscador de comandos
)
