local dap = require("dap")

dap.adapters.node2 = {
    type = "executable",
    command = vim.fn.exepath("node-debug2-adapter"),
}

dap.adapters.chrome = {
    type = "executable",
    command = vim.fn.exepath("chrome-debug-adapter"),
}

dap.adapters.firefox = {
    type = "executable",
    command = vim.fn.exepath("firefox-debug-adapter"),
}

dap.adapters.python = {
    type = "executable",
    command = vim.fn.exepath("debugpy-adapter"),
}
