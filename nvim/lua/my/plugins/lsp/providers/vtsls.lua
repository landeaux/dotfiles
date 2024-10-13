require("lspconfig.configs").vtsls = require("vtsls").lspconfig

return {
    filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
    settings = {
        vtsls = {
            tsserver = {
                globalPlugins = {},
            },
        },
        typescript = {
            format = {
                semicolons = "remove",
            },
        },
        javascript = {
            format = {
                semicolons = "remove",
            },
        },
    },
    before_init = function(params, config)
        local result = vim.system({ "npm", "query", "#vue" }, { cwd = params.workspaceFolders[1].name, text = true })
            :wait()
        if result.stdout ~= "[]" then
            local vuePluginConfig = {
                name = "@vue/typescript-plugin",
                location = require("mason-registry").get_package("vue-language-server"):get_install_path()
                    .. "/node_modules/@vue/language-server",
                languages = { "vue" },
                configNamespace = "typescript",
                enableForWorkspaceTypeScriptVersions = true,
            }
            table.insert(config.settings.vtsls.tsserver.globalPlugins, vuePluginConfig)
        end
    end,
}
