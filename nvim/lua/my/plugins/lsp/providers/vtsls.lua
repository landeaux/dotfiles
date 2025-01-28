require("lspconfig.configs").vtsls = require("vtsls").lspconfig

vim.lsp.commands["editor.action.showReferences"] = function(command, ctx)
    local locations = command.arguments[3]
    local client = vim.lsp.get_client_by_id(ctx.client_id)
    if locations and #locations > 0 and client ~= nil then
        local items = vim.lsp.util.locations_to_items(locations, client.offset_encoding)
        vim.fn.setloclist(0, {}, " ", { title = "References", items = items, context = ctx })
        vim.api.nvim_command("lopen")
    end
end

return {
    filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
    settings = {
        vtsls = {
            tsserver = {
                globalPlugins = {},
            },
        },
        typescript = {
            preferences = {
                quoteStyle = "single",
            },
            format = {
                semicolons = "remove",
            },
            inlayHints = {
                parameterNames = { enabled = "literals" },
                parameterTypes = { enabled = true },
                variableTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                enumMemberValues = { enabled = true },
            },
            referencesCodeLens = {
                enabled = false,
                showOnAllFunctions = true,
            },
            implementationsCodeLens = {
                enabled = false,
                showOnInterfaceMethods = true,
            },
        },
        javascript = {
            preferences = {
                quoteStyle = "single",
            },
            format = {
                semicolons = "remove",
            },
            referencesCodeLens = {
                enabled = false,
                showOnAllFunctions = true,
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
