local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = vim.fn.stdpath('data') .. '/jdtls-workspaces/' .. project_name

return {
    lua_ls = {
        settings = {
            Lua = {
                runtime = {
                    version = 'LuaJIT'
                },
                diagnostics = { globals = { 'vim' } },

                workspace = {
                    checkThirdParty = false,
                    library = {
                        vim.env.VIMRUNTIME,
                        vim.fn.expand("~/.local/share/nvim/lazy/fzf-lua")
                    }
                }
            }
        }
    },
    ts_ls = {},
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
                    true)
            }
        }
    },
    yamlls = {},
    cssls = {},
    jsonls = {},
    lemminx = {
        settings = {
            xml = {
                format = {
                    enabled = true,
                }
            }
        }
    }
}
