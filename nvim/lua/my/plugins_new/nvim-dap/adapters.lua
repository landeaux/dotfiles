local dap = require("dap")

local debugger_dir = vim.fn.stdpath("data") .. "/debuggers"

dap.adapters.node2 = {
    type = "executable",
    command = "node",
    args = { debugger_dir .. "/vscode-node-debug2/out/src/nodeDebug.js" },
}

dap.adapters.chrome = {
    type = "executable",
    command = "node",
    args = { debugger_dir .. "/vscode-chrome-debug/out/src/chromeDebug.js" },
}
