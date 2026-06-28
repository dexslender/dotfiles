vim.api.nvim_create_user_command(
    "SceneBuilder",
    function()
        local file_ext = vim.fn.expand("%:e")
        if file_ext == "fxml" then
            local current_file = vim.fn.expand("%:p")
            vim.fn.jobstart({ "/opt/scenebuilder/bin/SceneBuilder", current_file }, { detach = true })
            vim.notify("Editing with SceneBuilder: " .. vim.fn.expand("%:t"), vim.log.levels.INFO)
        else
            vim.notify("No .fxml file!", vim.log.levels.WARN)
        end
    end,
    { desc = "Open current FXML file with SceneBuilder" }
)
