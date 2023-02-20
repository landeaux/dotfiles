local dap = require("dap")

dap.adapters.node2 = {
    type = "executable",
    command = "node-debug2-adapter",
}

dap.adapters.chrome = {
    type = "executable",
    command = "chrome-debug-adapter",
}
