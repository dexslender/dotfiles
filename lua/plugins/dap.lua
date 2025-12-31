return {
    {
        'mfussenegger/nvim-dap',
        lazy = false,
        dependencies = {
            'rcarriga/nvim-dap-ui',
            'nvim-neotest/nvim-nio',
            {
                'leoluz/nvim-dap-go',
                opts = {
                    dap_configurations = {
                        {
                            type = "go",
                            name = "Start Debugging",
                            request = "launch",
                            program = ".",
                            -- console = "integratedTerminal",
                            outputMode = "remote"
                        },
                    }
                }
            }
        },
        keys = {
            { "<leader>db", "<cmd>DapToggleBreakpoint<cr>",            desc = "Setting breakpoints" },
            { "<leader>du", function() require("dapui").toggle() end,  desc = "Toggle Dap UI" },
            { "<leader>da", function() require("dap").continue() end,  desc = "Start Debugging" },
            { "<leader>ds", function() require("dap").terminate() end, desc = "Terminate debug session" },
            { "<leader>dr", function() require("dap").run_last() end,  desc = "Run Last" },
        },
        config = function()
            local dap = require 'dap'
            local dapui = require 'dapui'
            vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'DiagnosticError', linehl = '', numhl = '' })
            vim.fn.sign_define('DapStopped', { text = '', texthl = '', linehl = '', numhl = '' })

            dapui.setup {
                icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
                controls = {
                    element = "repl",
                    enabled = true,
                    icons = {
                        pause = '󰏤',
                        play = '󰐊',
                        step_into = '󰒭',
                        step_over = '󰙢',
                        step_out = '󰙤',
                        step_back = '󰒮',
                        run_last = '󰜉',
                        terminate = '󰓛',
                        disconnect = '',
                    },
                },
                element_mappings = {},
                expand_lines = true,
                floating = {
                    border = "single",
                    mappings = {
                        close = { "q", "<Esc>" },
                    }
                },
                force_buffers = true,
                mappings = {
                    edit = "e",
                    expand = { "<CR>", "<2-LeftMouse>" },
                    open = "o",
                    remove = "d",
                    repl = "r",
                    toggle = "t",
                },
                render = {
                    indent = 1,
                    max_value_lines = 100,
                },
                layouts = { {
                    elements = { {
                        id = "scopes",
                        size = 0.25,
                    }, {
                        id = "breakpoints",
                        size = 0.25,
                    }, {
                        id = "stacks",
                        size = 0.25,
                    }, {
                        id = "watches",
                        size = 0.25,
                    } },
                    position = "left",
                    size = 30
                }, {
                    elements = { {
                        id = "repl",
                        size = 0.5,
                    }, {
                        id = "console",
                        size = 0.5,
                    } },
                    position = "bottom",
                    size = 8
                } },
            }
            dap.listeners.after.event_initialized['dapui_config'] = dapui.open
            dap.listeners.before.event_terminated['dapui_config'] = dapui.close
            dap.listeners.before.event_exited['dapui_config'] = dapui.close
        end
    },
}
