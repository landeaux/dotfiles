local volar = require("mason-registry").get_package("vue-language-server")
local vue_ts_plugin_path = volar:get_install_path() .. "/node_modules/@vue/language-server"

return {
    init_options = {
        plugins = {
            {
                name = "@vue/typescript-plugin",
                location = vue_ts_plugin_path,
                languages = { "vue" },
            },
        },
    },
    filetypes = {
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "vue",
    },
}
