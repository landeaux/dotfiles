---@param config {args?:string[]|fun():string[]?}
local function get_args(config)
    local args = type(config.args) == "function" and (config.args() or {}) or config.args or {}
    config = vim.deepcopy(config)
    ---@cast args string[]
    config.args = function()
        local new_args = vim.fn.input("Run with args: ", table.concat(args, " ")) --[[@as string]]
        return vim.split(vim.fn.expand(new_args) --[[@as string]], " ")
    end
    return config
end

return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            dependencies = { "nvim-neotest/nvim-nio" },
            keys = {
                { "<leader>du", function() require("dapui").toggle({}) end, desc = "Dap UI" },
                { "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = { "n", "v" } },
            },
            opts = {},
            config = function(_, opts)
                local dap = require("dap")
                local dapui = require("dapui")
                dapui.setup(opts)
                dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open({}) end
                dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close({}) end
                dap.listeners.before.event_exited["dapui_config"] = function() dapui.close({}) end
            end,
        },
        keys = {
            {
                "<leader>dB",
                function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end,
                desc = "Breakpoint Condition",
            },
            { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
            { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
            { "<leader>da", function() require("dap").continue({ before = get_args }) end, desc = "Run with Args" },
            { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
            { "<leader>dg", function() require("dap").goto_() end, desc = "Go to Line (No Execute)" },
            { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
            { "<leader>dj", function() require("dap").down() end, desc = "Down" },
            { "<leader>dk", function() require("dap").up() end, desc = "Up" },
            { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
            { "<leader>do", function() require("dap").step_out() end, desc = "Step Out" },
            { "<leader>dO", function() require("dap").step_over() end, desc = "Step Over" },
            { "<leader>dp", function() require("dap").pause() end, desc = "Pause" },
            { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
            { "<leader>ds", function() require("dap").session() end, desc = "Session" },
            { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
            { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
        },
        config = function()
            local colors = {
                breakpoint_icon = "#aa0000",
                breakpoint_line = "#880000",
                conditional_breakpoint_icon = "#aa4400",
                conditional_breakpoint_line = "#884400",
                log_point_icon = "#aaaa00",
                log_point_line = "#888800",
                stopped_icon = "#0000aa",
                stopped_line = "#000088",
            }

            -- Customize symbols and highlights
            vim.cmd("hi DapBreakpointIcon guifg=" .. colors.breakpoint_icon)
            vim.cmd("hi DapBreakpointLine guibg=" .. colors.breakpoint_line)
            vim.cmd("hi link DapBreakpointNumber DapBreakpointIcon")

            vim.cmd("hi DapBreakpointConditionIcon guifg=" .. colors.conditional_breakpoint_icon)
            vim.cmd("hi DapBreakpointConditionLine guibg=" .. colors.conditional_breakpoint_line)
            vim.cmd("hi link DapBreakpointConditionNumber DapBreakpointConditionIcon")

            vim.cmd("hi DapLogPointIcon guifg=" .. colors.log_point_icon)
            vim.cmd("hi DapLogPointLine guibg=" .. colors.log_point_line)
            vim.cmd("hi link DapLogPointNumber DapLogPointIcon")

            vim.cmd("hi DapStoppedIcon guifg=" .. colors.stopped_icon)
            vim.cmd("hi DapStoppedLine guibg=" .. colors.stopped_line .. " gui=bold")
            vim.cmd("hi link DapStoppedNumber DapStoppedIcon")

            vim.fn.sign_define("DapBreakpoint", {
                text = "",
                texthl = "DapBreakpointIcon",
                linehl = "DapBreakpointLine",
                numhl = "DapBreakpointNumber",
            })
            vim.fn.sign_define("DapBreakpointCondition", {
                text = "",
                texthl = "DapBreakpointConditionIcon",
                linehl = "DapBreakpointConditionLine",
                numhl = "DapBreakpointConditionNumber",
            })
            vim.fn.sign_define("DapLogPoint", {
                text = "",
                texthl = "DapLogPointIcon",
                linehl = "DapLogPointLine",
                numhl = "DapLogPointNumber",
            })
            vim.fn.sign_define("DapStopped", {
                text = "󰁕",
                texthl = "DapStoppedIcon",
                linehl = "DapStoppedLine",
                numhl = "DapStoppedNumber",
            })
            vim.fn.sign_define("DapBreakpointRejected", {
                text = "",
                texthl = "DiagnosticError",
                linehl = "DiagnosticError",
                numhl = "DiagnosticError",
            })

            -- setup dap config by VsCode launch.json file
            local vscode = require("dap.ext.vscode")
            local json = require("plenary.json")
            vscode.json_decode = function(str) return vim.json.decode(json.json_strip_comments(str)) end

            -- DAP REPL autocomplete
            require("my.utils").create_augroup({
                {
                    event = "FileType",
                    opts = { pattern = "dap-repl", command = 'lua require("dap.ext.autocompl").attach()' },
                },
            }, "_dap_repl")

            -- DAP Terminal settings
            -- @see :h dap-terminal
            require("dap").defaults.fallback.external_terminal = {
                command = "kitty",
                args = {},
            }

            require("my.plugins.dap.adapters")
            require("my.plugins.dap.configurations")
        end,
    },
    {
        "theHamsta/nvim-dap-virtual-text",
        dependencies = { "mfussenegger/nvim-dap" },
        opts = {},
    },
}
