vim.diagnostic.config({
    underline = true,
    float = {
        header = "",
        source = true,
        border = "rounded",
    },
    virtual_text = false,
    virtual_lines = {
        current_line = true,
    },
    signs = {
        priority = 20,
        text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.HINT] = " ",
            [vim.diagnostic.severity.INFO] = " ",
        },
        numhl = {
            [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
            [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
            [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
            [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
        },
    },
    update_in_insert = true,
    severity_sort = true,
})
