return {
    {
        "mxsdev/nvim-dap-vscode-js",
        version = "v1.74.1",
        dependencies = { "mfussenegger/nvim-dap" },
        config = function() require("my.plugins.nvim-dap-vscode-js.config") end,
    },
    {
        "microsoft/vscode-js-debug",
        lazy = true,
        build = "npm install --legacy-peer-deps && npm run compile",
        tag = "v1.74.1",
    },
}
