require("dap-vscode-js").setup({
    debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug", -- Path to vscode-js-debug installation.
    adapters = { "pwa-node", "pwa-chrome" }, -- which adapters to register in nvim-dap
})

for _, language in ipairs({ "typescript", "javascript" }) do
    require("dap").configurations[language] = {
        {
            type = "pwa-node",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            cwd = "${workspaceFolder}",
        },
        {
            type = "pwa-node",
            request = "attach",
            name = "Attach",
            processId = require("dap.utils").pick_process,
            cwd = "${workspaceFolder}",
        },
        {
            type = "pwa-chrome",
            request = "launch",
            -- skipFiles = { "${workspaceFolder}/node_modules/**/*.js" },
            skipFiles = { "<node_internals>/**", "**/node_modules/**" },
            smartStep = true,
            name = "Debug app",
            url = "http://localhost:8080",
            webRoot = "${workspaceFolder}",
        },
    }
end
