return {
    {
        'nvim-mini/mini.starter',
        version = '*',
        opts = {},
        config = function()
            local starter = require('mini.starter')
            starter.setup {
                items = {
                    starter.sections.recent_files(5, false, false),
                    { name = 'Open NvimTree', action = 'NvimTreeOpen', section = 'Builtin actions' },
                    starter.sections.builtin_actions(),
                },
            }
        end
    },
    {
        "j-hui/fidget.nvim",
        opts = {
            -- options
        },
    },
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        opts = {
            view = {
                width = 30,
            },
            filters = { custom = { "^.git$" } },
        },
    },
    {
        'romgrk/barbar.nvim',
        dependencies = {
            'lewis6991/gitsigns.nvim',
            'nvim-tree/nvim-web-devicons',
        },
        init = function() vim.g.barbar_auto_setup = false end,
        opts = {},
        version = '^1.0.0',
    },
    {
        "EdenEast/nightfox.nvim",
        init = function() vim.cmd("colorscheme duskfox") end,
        opts = {
            options = {
                styles = {
                    comments = "italic",
                    keywords = "bold",
                    types    = "italic,bold",
                }
            },
            specs = {
                all = {
                    syntax = {
                        variable = "#cccccc"
                    },

                }
            }
        },
    },
    {
        "sschleemilch/slimline.nvim",
        opts = {
            spaces = {
                components = "",
                left = "",
                right = "",
            },
            sep = {
                hide = {
                    first = true,
                    last = true,
                },
                left = "",
                right = "",
            },
        },
    },
}
