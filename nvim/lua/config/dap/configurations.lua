local dap = require("dap")

local node2 = {
    type = "node2",
    request = "launch",
    name = "Launch node2 debugger",
    program = "${workspaceFolder}/${file}",
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = "inspector",
    console = "integratedTerminal",
}

local chrome = {
    type = "chrome",
    request = "attach",
    name = "Attach to Chrome debugger",
    program = "${file}",
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = "inspector",
    port = 9222,
    webRoot = "${workspaceFolder}",
}

dap.configurations.javascript = {
    node2,
    chrome,
}

dap.configurations.typescript = {
    node2,
    chrome,
}

dap.configurations.javascriptreact = {
    node2,
    chrome,
}

dap.configurations.typescriptreact = {
    node2,
    chrome,
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
