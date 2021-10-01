local dap = require("dap")

dap.adapters.node2 = {
    type = "executable",
    command = "node",
    args = { vim.fn.stdpath("data") .. "/debuggers/vscode-node-debug2/out/src/nodeDebug.js" },
}

dap.configurations.javascript = {
    {
        type = "node2",
        request = "launch",
        program = "${workspaceFolder}/${file}",
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = "inspector",
        console = "integratedTerminal",
    },
}

dap.configurations.python = {
    {
        type = "python",
        request = "attach",
        name = "Attach remote (custom)",
        cwd = vim.fn.getcwd(),
        host = function()
            local value = vim.fn.input("Host [127.0.0.1]: ")
            if value ~= "" then
                return value
            end
            return "127.0.0.1"
        end,
        port = function()
            return tonumber(vim.fn.input("Port [5678]: ")) or 5678
        end,
        pathMappings = function()
            local remoteRoot = vim.fn.input("Remote Root [/]: ")
            if remoteRoot == "" then
                remoteRoot = "/"
            end
            return {
                {
                    localRoot = vim.fn.getcwd(),
                    remoteRoot = remoteRoot,
                },
            }
        end,
    },
}
