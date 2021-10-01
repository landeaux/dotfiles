local dap = require("dap")

-- javascript: node
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

-- javascript: chrome
dap.adapters.chrome = {
    type = "executable",
    command = "node",
    args = { vim.fn.stdpath("data") .. "/debuggers/vscode-chrome-debug/out/src/chromeDebug.js" },
}
dap.configurations.javascriptreact = { -- change this to javascript if needed
    {
        type = "chrome",
        request = "attach",
        program = "${file}",
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = "inspector",
        port = 9222,
        webRoot = "${workspaceFolder}",
    },
}
dap.configurations.typescriptreact = { -- change to typescript if needed
    {
        type = "chrome",
        request = "attach",
        program = "${file}",
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = "inspector",
        port = 9222,
        webRoot = "${workspaceFolder}",
    },
}
dap.configurations.vue = {
    {
        type = "chrome",
        request = "launch",
        name = "vuejs: chrome",
        url = "http://localhost:8080",
        webRoot = "${workspaceFolder}",
        breakOnLoad = true,
        pathMapping = {
            ["/_karma_webpack_"] = "${workspaceFolder}",
        },
        sourceMaps = true,
        sourceMapPathOverrides = {
            ["webpack:/*"] = "${webRoot}/*",
            ["/./*"] = "${webRoot}/*",
            ["/src/*"] = "${webRoot}/*",
            ["/*"] = "*",
            ["/./~/*"] = "${webRoot}/node_modules/*",
        },
    },
}

-- python
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
