local M = {}

M.flags = {
    debounce_text_changes = 150,
}

M.capabilities = {
    textDocument = {
        colorProvider = {
            dynamicRegistration = true,
        },
    },
}
M.capabilities = require("blink.cmp").get_lsp_capabilities(M.capabilities)

M.autostart = true

return M
