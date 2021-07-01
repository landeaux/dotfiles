local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
        "documentation",
        "detail",
        "additionalTextEdits",
    },
}

require("lspconfig").vuels.setup({
    cmd = { vim.fn.stdpath("data") .. "/lspinstall/vue/node_modules/.bin/vls", "--stdio" },
    on_attach = require("config.lsp.nvim-lsp-settings").vuels_on_attach,
    flags = {
        debounce_text_changes = 150,
    },
    capabilities = capabilities,
    settings = {
        vetur = {
            ignoreProjectWarning = false,
            useWorkspaceDependencies = true,
            validation = {
                template = true,
                templateProps = false,
                interpolation = true,
                style = true,
                script = true,
            },
            completion = {
                autoImport = true,
                tagCasing = "initial",
                scaffoldSnippetSources = { workspace = "", user = "", vetur = "﵂" },
            },
            grammar = { customBlocks = {} },
            format = {
                enable = false,
                options = { tabSize = 2, useTabs = false },
                defaultFormatter = {
                    html = { "prettier" },
                    js = { "prettier-eslint" },
                    sass = { "sass-formatter" },
                },
                defaultFormatterOptions = {},
                scriptInitialIndent = false,
                styleInitialIndent = false,
            },
            languageFeatures = { codeActions = true, updateImportOnFileMove = true },
            trace = { server = "off" },
            dev = { vlsPath = "", vlsPort = -1, logLevel = "INFO" },
            experimental = { templateInterpolationService = false },
        },
        css = {},
        html = { suggest = {} },
        javascript = { format = {} },
        typescript = { tsdk = nil, format = {} },
        emmet = {},
        stylusSupremacy = {},
    },
})
