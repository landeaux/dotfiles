local dap = require("dap")

for _, language in ipairs({ "javascript", "javascriptreact", "typescript", "typescriptreact" }) do
    dap.configurations[language] = {
        {
            name = "Node2: Launch",
            type = "node2",
            request = "launch",
            program = "${file}",
            cwd = vim.fn.getcwd(),
            sourceMaps = true,
            protocol = "inspector",
            console = "integratedTerminal",
        },
        {
            -- For this to work you need to make sure the node process is started with the `--inspect` flag.
            name = "Node2: Attach to process",
            type = "node2",
            request = "attach",
            processId = require("dap.utils").pick_process,
        },
        {
            name = "Chrome: Debug",
            type = "chrome",
            request = "attach",
            program = "${file}",
            cwd = vim.fn.getcwd(),
            sourceMaps = true,
            protocol = "inspector",
            port = 9222,
            webRoot = "${workspaceFolder}",
        },
        {
            name = "Firefox: Debug",
            type = "firefox",
            request = "launch",
            reAttach = true,
            url = "http://localhost:3000",
            webRoot = "${workspaceFolder}",
            firefoxExecutable = vim.fn.exepath("firefox"),
        },
    }
end

dap.configurations.vue = {
    {
        name = "Chrome: Launch for Vue App",
        type = "chrome",
        request = "launch",
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

local venv_path = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX")
dap.configurations.python = {
    {
        name = "Python: Launch file",
        type = "python",
        request = "launch",
        program = "${file}",
        pythonPath = venv_path and venv_path .. "/bin/python" or nil,
        console = "integratedTerminal",
    },
    {
        name = "Python: Attach remote",
        type = "python",
        request = "attach",
        cwd = vim.fn.getcwd(),
        host = function()
            local value = vim.fn.input("Host [127.0.0.1]: ")
            if value ~= "" then
                return value
            end
            return "127.0.0.1"
        end,
        port = function() return tonumber(vim.fn.input("Port [5678]: ")) or 5678 end,
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
