return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            dependencies = { "nvim-neotest/nvim-nio" },
            keys = {
                { "<leader>du", function() require("dapui").toggle({}) end, desc = "[DAP] Dap UI" },
                { "<leader>de", function() require("dapui").eval() end, desc = "[DAP] Eval", mode = { "n", "v" } },
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
            { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "[DAP] Toggle Breakpoint" },
            {
                "<leader>dBc",
                function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end,
                desc = "[DAP] Set conditional breakpoint",
            },
            {
                "<leader>dBl",
                function() require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: ")) end,
                desc = "[DAP] Set log point",
            },
            {
                "<leader>dBe",
                function() require("dap").set_exception_breakpoints() end,
                desc = "[DAP] Set exception breakpoints",
            },
            { "<leader>dc", function() require("dap").continue() end, desc = "[DAP] Continue" },
            { "<leader>dl", function() require("dap").run_last() end, desc = "[DAP] Run Last" },
            { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "[DAP] Run to Cursor" },
            { "<leader>dg", function() require("dap").goto_() end, desc = "[DAP] Go to Line (No Execute)" },
            { "<leader>dp", function() require("dap").pause() end, desc = "[DAP] Pause" },
            { "<leader>di", function() require("dap").step_into() end, desc = "[DAP] Step Into" },
            { "<leader>do", function() require("dap").step_out() end, desc = "[DAP] Step Out" },
            { "<leader>dO", function() require("dap").step_over() end, desc = "[DAP] Step Over" },
            { "<leader>dh", function() require("dap").step_back() end, desc = "[DAP] Step Back" },
            { "<leader>dj", function() require("dap").down() end, desc = "[DAP] Down" },
            { "<leader>dk", function() require("dap").up() end, desc = "[DAP] Up" },
            { "<leader>dr", function() require("dap").repl.toggle() end, desc = "[DAP] Toggle REPL" },
            { "<leader>ds", function() require("dap").session() end, desc = "[DAP] Session" },
            { "<leader>dq", function() require("dap").terminate() end, desc = "[DAP] Terminate" },
            { "<leader>dK", function() require("dap.ui.widgets").hover() end, desc = "[DAP] Widgets" },
        },
        config = function()
            vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual", bold = true })
            vim.api.nvim_set_hl(0, "DapStoppedNumber", { default = true, link = "CursorLineNr" })

            local dap_icons = {
                Stopped = { "󰁕", "DiagnosticSignWarn", "DapStoppedLine", "DapStoppedNumber" },
                Breakpoint = { "", "DiagnosticSignError" },
                BreakpointCondition = { "", "DiagnosticSignError" },
                BreakpointRejected = { "", "DiagnosticSignError" },
                LogPoint = { "", "DiagnosticSignError" },
            }
            for name, sign in pairs(dap_icons) do
                vim.fn.sign_define(
                    "Dap" .. name,
                    { text = sign[1], texthl = sign[2], linehl = sign[3], numhl = sign[4] }
                )
            end

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
        "mxsdev/nvim-dap-vscode-js",
        tag = "v1.1.0",
        dependencies = {
            "mfussenegger/nvim-dap",
            {
                "microsoft/vscode-js-debug",
                tag = "v1.76.1",
                lazy = true,
                build = "npm install --legacy-peer-deps && npm run compile",
            },
        },
        config = function()
            ---@diagnostic disable-next-line: missing-fields
            require("dap-vscode-js").setup({
                debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
                adapters = { "pwa-node", "pwa-chrome" },
            })

            for _, language in ipairs({ "typescript", "javascript" }) do
                local configurations = require("dap").configurations[language]
                local configurations_to_add = {
                    {
                        type = "pwa-node",
                        request = "launch",
                        name = "PWA-node: Launch file",
                        program = "${file}",
                        cwd = "${workspaceFolder}",
                    },
                    {
                        type = "pwa-node",
                        request = "attach",
                        name = "PWA-node: Attach",
                        processId = require("dap.utils").pick_process,
                        cwd = "${workspaceFolder}",
                    },
                    {
                        type = "pwa-node",
                        request = "launch",
                        name = "PWA-node: Debug Vitest Tests",
                        -- trace = true, -- include debugger info
                        runtimeExecutable = "node",
                        runtimeArgs = {
                            "./node_modules/vitest/vitest.mjs",
                            "--no-file-parallelism",
                        },
                        rootPath = "${workspaceFolder}",
                        cwd = "${workspaceFolder}",
                        console = "integratedTerminal",
                        internalConsoleOptions = "neverOpen",
                    },
                    {
                        type = "pwa-chrome",
                        request = "launch",
                        -- skipFiles = { "${workspaceFolder}/node_modules/**/*.js" },
                        skipFiles = { "<node_internals>/**", "**/node_modules/**" },
                        smartStep = true,
                        name = "PWA-chrome: Debug app",
                        url = "http://localhost:8080",
                        webRoot = "${workspaceFolder}",
                    },
                }

                for _, value in ipairs(configurations_to_add) do
                    table.insert(configurations, value)
                end
            end
        end,
    },
    {
        "theHamsta/nvim-dap-virtual-text",
        dependencies = { "mfussenegger/nvim-dap" },
        opts = {},
    },
}
