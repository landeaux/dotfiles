local nvm_dir = vim.env.NVM_DIR
local node_version = vim.fn.system("node --version"):gsub("%s+$", "")

local vue_typescript_plugin_location = nvm_dir
    .. "/versions/node/"
    .. node_version
    .. "/lib/node_modules/@vue/typescript-plugin"

return {
    init_options = {
        plugins = {
            {
                name = "@vue/typescript-plugin",
                location = vue_typescript_plugin_location,
                languages = { "javascript", "typescript", "vue" },
            },
        },
    },
    filetypes = {
        "javascript",
        "typescript",
        "vue",
    },
}
