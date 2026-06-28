local langs = require("config.langs")

return {
    {
        "romus204/tree-sitter-manager.nvim",
        cmd = {
            "TSInstall",
            "TSManager",
            "TSUninstall",
            "TSUpdate",
        },
        dependencies = {}, -- tree-sitter CLI must be installed system-wide
        config = true,
    },
    {
        'neovim/nvim-lspconfig',
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            'saghen/blink.cmp',
        },
        opts = { servers = langs },
        config = function(_, opts)
            local capabilities = require('blink.cmp').get_lsp_capabilities()
            for server, config in pairs(opts.servers) do
                if config.enabled == nil or config.enabled == true then
                    capabilities.textDocument.completion.completionItem.snippetSupport = true
                    config.capabilities = capabilities
                    vim.lsp.config(server, config)
                    vim.lsp.enable(server)
                end
            end

            vim.api.nvim_create_autocmd('LspAttach', {
                desc = 'LSP actions',
                callback = function()
                    local bufmap = function(mode, lhs, rhs)
                        local bufopts = { buffer = true }
                        vim.keymap.set(mode, lhs, rhs, bufopts)
                    end

                    -- Displays hover information about the symbol under the cursor
                    bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')

                    -- Jump to the definition
                    bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')

                    -- Jump to declaration
                    bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')

                    -- Lists all the implementations for the symbol under the cursor
                    bufmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')

                    -- Jumps to the definition of the type symbol
                    bufmap('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>')

                    -- Lists all the references
                    bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')

                    -- Displays a function's signature information
                    bufmap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>')

                    -- Renames all references to the symbol under the cursor
                    bufmap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>')

                    -- Selects a code action available at the current cursor position
                    bufmap('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>')

                    -- Show diagnostics in a floating window
                    bufmap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')

                    -- Move to the previous diagnostic
                    bufmap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')

                    -- Move to the next diagnostic
                    bufmap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')

                    bufmap('n', '<F3>', '<cmd>lua vim.lsp.buf.format()<cr>')
                end
            })
        end
    },
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        build = ":Copilot auth",
        -- event = "InsertEnter",
        opts = {
            suggestion = {
                enabled = true,
                auto_trigger = true,
                debounce = 75,
                keymap = {
                    accept = "<M-l>",  -- Presiona Alt + l para aceptar la sugerencia completa
                    next = "<M-]>",    -- Alt + ] para ver la siguiente opción
                    prev = "<M-[>",    -- Alt + [ para ver la opción anterior
                    dismiss = "<C-]>", -- Ctrl + ] para ocultar temporalmente
                },
            },
            panel = { enabled = false },
        },
    },
    {
        'saghen/blink.cmp',
        lazy = true,
        dependencies = { 'rafamadriz/friendly-snippets' },
        version = '1.*',
        opts = {
            keymap = { preset = 'enter' },
            completion = {
                ghost_text = { enabled = true }
            },
        },
        opts_extend = { "sources.default" },
    },
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true,
    },
    {
        'numToStr/Comment.nvim',
        config = true,
        keys = { { "gcc", desc = "Comment current line" }, { "gc", mode = "v", desc = "Comment selected text" } },
    }
}
