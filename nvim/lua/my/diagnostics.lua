local diagnostic_config = {
    underline = true,
    float = {
        header = "",
        source = "always",
        border = "rounded",
    },
    virtual_text = false,
    signs = {
        enable = true,
        priority = 20,
    },
    update_in_insert = true,
}

vim.diagnostic.config(diagnostic_config)

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }

for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
