-- nvim-dap setup

-- Highlights and signs
vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual", bold = true })
vim.api.nvim_set_hl(0, "DapStoppedNumber", { default = true, link = "CursorLineNr" })

local dap_icons = {
    Stopped = { "󰁕", "DapStopped", "DapStoppedLine", "DapStoppedNumber" },
    Breakpoint = { "", "DapBreakpoint" },
    BreakpointCondition = { "", "DapBreakpointCondition" },
    BreakpointRejected = { "", "DapBreakpointRejected" },
    LogPoint = { "", "DapLogPoint" },
}
for name, sign in pairs(dap_icons) do
    vim.fn.sign_define("Dap" .. name, { text = sign[1], texthl = sign[2], linehl = sign[3], numhl = sign[4] })
end

-- setup dap config by VsCode launch.json file
local json = require("plenary.json")
local vscode = require("dap.ext.vscode")
---@diagnostic disable-next-line: duplicate-set-field
vscode.json_decode = function(str) return vim.json.decode(json.json_strip_comments(str, {})) end

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

-- nvim-dap-ui setup
local dap, dapui = require("dap"), require("dapui")
dapui.setup({})
dap.listeners.before.attach.dapui_config = function() dapui.open() end
dap.listeners.before.launch.dapui_config = function() dapui.open() end
dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

-- dap-ui keymaps
vim.keymap.set("n", "<leader>du", function() require("dapui").toggle({}) end, { desc = "[DAP] Dap UI" })
vim.keymap.set({ "n", "v" }, "<leader>de", function() require("dapui").eval() end, { desc = "[DAP] Eval" })

-- nvim-dap keymaps
vim.keymap.set(
    "n",
    "<leader>db",
    function() require("dap").toggle_breakpoint() end,
    { desc = "[DAP] Toggle Breakpoint" }
)
vim.keymap.set(
    "n",
    "<leader>dBc",
    function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end,
    { desc = "[DAP] Set conditional breakpoint" }
)
vim.keymap.set(
    "n",
    "<leader>dBl",
    function() require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: ")) end,
    { desc = "[DAP] Set log point" }
)
vim.keymap.set(
    "n",
    "<leader>dBe",
    function() require("dap").set_exception_breakpoints() end,
    { desc = "[DAP] Set exception breakpoints" }
)
vim.keymap.set("n", "<leader>dc", function() require("dap").continue() end, { desc = "[DAP] Continue" })
vim.keymap.set("n", "<leader>dl", function() require("dap").run_last() end, { desc = "[DAP] Run Last" })
vim.keymap.set("n", "<leader>dC", function() require("dap").run_to_cursor() end, { desc = "[DAP] Run to Cursor" })
vim.keymap.set("n", "<leader>dg", function() require("dap").goto_() end, { desc = "[DAP] Go to Line (No Execute)" })
vim.keymap.set("n", "<leader>dp", function() require("dap").pause() end, { desc = "[DAP] Pause" })
vim.keymap.set("n", "<leader>di", function() require("dap").step_into() end, { desc = "[DAP] Step Into" })
vim.keymap.set("n", "<leader>do", function() require("dap").step_out() end, { desc = "[DAP] Step Out" })
vim.keymap.set("n", "<leader>dO", function() require("dap").step_over() end, { desc = "[DAP] Step Over" })
vim.keymap.set("n", "<leader>dh", function() require("dap").step_back() end, { desc = "[DAP] Step Back" })
vim.keymap.set("n", "<leader>dj", function() require("dap").down() end, { desc = "[DAP] Down" })
vim.keymap.set("n", "<leader>dk", function() require("dap").up() end, { desc = "[DAP] Up" })
vim.keymap.set("n", "<leader>dr", function() require("dap").repl.toggle() end, { desc = "[DAP] Toggle REPL" })
vim.keymap.set("n", "<leader>ds", function() require("dap").session() end, { desc = "[DAP] Session" })
vim.keymap.set("n", "<leader>dq", function() require("dap").terminate() end, { desc = "[DAP] Terminate" })
vim.keymap.set("n", "<leader>dK", function() require("dap.ui.widgets").hover() end, { desc = "[DAP] Widgets" })

-- nvim-dap-vscode-js setup
---@diagnostic disable-next-line: missing-fields
require("dap-vscode-js").setup({
    debugger_path = vim.fn.stdpath("data") .. "/site/pack/dist/opt/vscode-js-debug",
    adapters = { "pwa-node", "pwa-chrome" },
})

for _, language in ipairs({ "javascript", "javascriptreact", "typescript", "typescriptreact" }) do
    require("dap").configurations[language] = require("dap").configurations[language] or {}
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

-- nvim-dap-virtual-text setup
require("nvim-dap-virtual-text").setup({})

require("my.plugins.dap.adapters")
require("my.plugins.dap.configurations")
