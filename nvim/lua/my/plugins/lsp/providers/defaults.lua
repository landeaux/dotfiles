local M = {}

M.flags = {
    debounce_text_changes = 150,
}

M.capabilities = require("cmp_nvim_lsp").default_capabilities()
M.capabilities.textDocument.colorProvider = {
    dynamicRegistration = true,
}

M.autostart = true

return M
