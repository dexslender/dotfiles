local vue_plugin = {
    name = '@vue/typescript-plugin',
    location = '',
    languages = { 'vue' },
}
local tsserver_filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" }

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = vim.fn.stdpath('data') .. '/jdtls-workspaces/' .. project_name

return {
    lua_ls = {
        settings = {
            Lua = {
                diagnostics = { globals = { 'vim' } },
            }
        }
    },
    gopls = {
        settings = {
            gopls = {
                analyses = { unusedparams = true },
                staticcheck = true,
                gofumpt = true,
                semanticTokens = true,
            }
        }
    },
    ts_ls = {
        cmd = { 'bunx', 'typescript-language-server', '--stdio' },
        init_options = {
            plugins = {
                vue_plugin
            },
        },
        filetypes = tsserver_filetypes,
    },
    vue_ls = {
        cmd = { 'bunx', '@vue/language-server', '--stdio' }
    },
    rust_analyzer = {},
    qmlls = {
        cmd = { "qmlls6" }
    },
    jdtls = {
        cmd = {
            'jdtls',
            '-data', workspace_dir
        },
        init_options = {
            bundles = {
                vim.fn.glob(
                    "/home/dexslender/devtools/vscjava/extension/server/com.microsoft.java.debug.plugin-*.jar",
                    1)
            }
        }
    },
    yamlls = {},
    taplo = {},
    cssls = {},
    jsonls = {},
    clangd = {},
}
