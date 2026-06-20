local function open_win_config_func()
    local scr_w = vim.opt.columns:get()
    local scr_h = vim.opt.lines:get()
    local tree_w = 80
    local tree_h = math.floor(tree_w * scr_h / scr_w)
    return {
        -- border = "single",
        relative = "editor",
        width = tree_w,
        height = tree_h,
        col = (scr_w - tree_w) / 2,
        row = (scr_h - tree_h) / 2
    }
end

return {
    'mfussenegger/nvim-jdtls',
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
        'diogof146/java-project-creator.nvim',
        dependencies = { 'MunifTanjim/nui.nvim' },     -- Optional but recommended for UI
        opts = {
            base_path = vim.fn.getcwd(),               -- Default path for new projects
            default_java_version = "25",               -- Java version to use (supports 8-21)
            default_group_id = "me.eduj",              -- Default Maven group ID
            default_artifact_id = "myapp",             -- Default Maven artifact ID
            default_version = "1.0-SNAPSHOT",          -- Default Maven version
            maven_cmd = "mvn",                         -- Maven command to use
            keymaps = {
                new_java_project = "<localleader>njp", -- Keymap for new Java project
                new_maven_project = "<localleader>nmp" -- Keymap for new Maven project
            }
        }
    },
    {
        "j-hui/fidget.nvim",
        opts = {},
    },
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        keys = {
            { "<leader>ff", "<cmd>NvimTreeToggle<cr>", desc = "Find Files" },
        },
        opts = {
            view = {
                signcolumn = "yes",
                -- width = 30,
                float = {
                    enable = true,
                    open_win_config = open_win_config_func,
                },
            },
            modified = { enable = true },
            filters = { custom = { "^.git$" } },
        },
    },
    {
        "ibhagwan/fzf-lua",
        -- optional for icon support
        lazy = true,
        dependencies = { "nvim-tree/nvim-web-devicons" },
        -- or if using mini.icons/mini.nvim
        -- dependencies = { "nvim-mini/mini.icons" },
        ---@module "fzf-lua"
        ---@type fzf-lua.Config|{}
        ---@diagnostics disable: missing-fields
        opts = {}
        ---@diagnostics enable: missing-fields
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
                -- transparent = true,
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
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        enabled = true,
        opts = {
            options = {
                icons_enabled = true,
                theme = 'auto',
                component_separators = { left = '', right = '' },
                section_separators = { left = '', right = '' },
                disabled_filetypes = {
                    "dapui_stack",
                    "dapui_watches",
                    statusline = {},
                    winbar = {},
                },
                ignore_focus = {},
                always_divide_middle = true,
                always_show_tabline = true,
                globalstatus = true,
                refresh = {
                    statusline = 1000,
                    tabline = 1000,
                    winbar = 1000,
                    refresh_time = 16, -- ~60fps
                    events = {
                        'WinEnter',
                        'BufEnter',
                        'BufWritePost',
                        'SessionLoadPost',
                        'FileChangedShellPost',
                        'VimResized',
                        'Filetype',
                        'CursorMoved',
                        'CursorMovedI',
                        'ModeChanged',
                    },
                }
            },
            sections = {
                lualine_a = { 'mode' },
                lualine_b = { 'branch', 'diff', 'diagnostics' },
                lualine_c = { 'filename' },
                lualine_x = { 'encoding', 'fileformat', 'filetype' },
                lualine_y = { 'progress' },
                lualine_z = { 'location' }
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { 'filename' },
                lualine_x = { 'location' },
                lualine_y = {},
                lualine_z = {}
            },
            tabline = {},
            winbar = {},
            inactive_winbar = {},
            extensions = {}
        }
    },
}
