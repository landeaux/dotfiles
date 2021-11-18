-- Diagnostics
local diagnostic_config = {
    underline = true,
    float = {
        header = "",
        source = "always",
        border = "rounded",
    },
    virtual_text = {
        source = "always",
        spacing = 4,
        prefix = "■", -- ﱢ
        -- severity = {
        --     min = vim.diagnostic.severity.HINT,
        -- },
    },
    signs = {
        enable = true,
        priority = 20,
    },
    update_in_insert = false,
}

vim.diagnostic.config(diagnostic_config)

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }

for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
