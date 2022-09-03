local lspconfig_util = require("lspconfig.util")
local lspconfig_configs = require("lspconfig.configs")

local M = {}

local settings = {
    volar = {
        codeLens = {
            scriptSetupTools = true,
            references = true,
            pugTools = false,
        },
        autoCompleteRefs = true,
        completion = {
            autoImportComponent = true,
        },
    },
    -- ["volar-api"] = {
    --     trace = {
    --         server = "verbose",
    --     },
    -- },
    -- ["volar-document"] = {
    --     trace = {
    --         server = "verbose",
    --     },
    -- },
    -- ["volar-html"] = {
    --     trace = {
    --         server = "verbose",
    --     },
    -- },
}

local commands = {
    VolarUseSetupSugar = {
        function()
            vim.lsp.buf.execute_command({
                command = "volar.use-setup-sugar",
                arguments = { vim.uri_from_bufnr(0) },
            })
        end,
    },
    VolarUnuseSetupSugar = {
        function()
            vim.lsp.buf.execute_command({
                command = "volar.unuse-setup-sugar",
                arguments = { vim.uri_from_bufnr(0) },
            })
        end,
    },
    VolarUseRefSugar = {
        function()
            vim.lsp.buf.execute_command({
                command = "volar.use-ref-sugar",
                arguments = { vim.uri_from_bufnr(0) },
            })
        end,
    },
    VolarUnuseRefSugar = {
        function()
            vim.lsp.buf.execute_command({
                command = "volar.unuse-ref-sugar",
                arguments = { vim.uri_from_bufnr(0) },
            })
        end,
    },
    VolarShowReferences = {
        function()
            vim.lsp.buf.execute_command({
                command = "volar.show-references",
                arguments = { vim.uri_from_bufnr(0) },
            })
        end,
    },
    VolarConvertToKebabCase = {
        function()
            vim.lsp.buf.execute_command({
                command = "volar.server.executeConvertToKebabCase",
                arguments = { vim.uri_from_bufnr(0) },
            })
        end,
    },
    VolarConvertToPascalCase = {
        function()
            vim.lsp.buf.execute_command({
                command = "volar.server.executeConvertToPascalCase",
                arguments = { vim.uri_from_bufnr(0) },
            })
        end,
    },
}

function M.register_volar_lspconfigs()
    -- local filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" }
    local filetypes = { "vue" }

    local volar_root_dir = lspconfig_util.root_pattern("package.json")

    local volar_bin_path = vim.fn.stdpath("data") .. "/mason/bin/vue-language-server"
    local volar_cmd = { volar_bin_path, "--stdio" }

    local volar_common = {
        cmd = volar_cmd,
        root_dir = volar_root_dir,
        on_new_config = M.on_new_config,
        -- trace = "verbose",
        settings = settings,
    }

    lspconfig_configs.volar_api = {
        default_config = vim.tbl_extend("keep", volar_common, {
            filetypes = filetypes,
            commands = commands,
            init_options = {
                typescript = {
                    serverPath = "",
                },
                languageFeatures = {
                    implementation = true,
                    references = true,
                    definition = true,
                    typeDefinition = true,
                    callHierarchy = true,
                    hover = true,
                    rename = true,
                    renameFileRefactoring = true,
                    signatureHelp = true,
                    codeAction = true,
                    workspaceSymbol = true,
                    completion = {
                        defaultTagNameCase = "both",
                        defaultAttrNameCase = "kebabCase",
                        getDocumentNameCasesRequest = false,
                        getDocumentSelectionRequest = false,
                    },
                },
            },
        }),
    }

    lspconfig_configs.volar_doc = {
        default_config = vim.tbl_extend("keep", volar_common, {
            filetypes = filetypes,
            init_options = {
                typescript = {
                    serverPath = "",
                },
                languageFeatures = {
                    implementation = true,
                    documentHighlight = true,
                    documentLink = true,
                    codeLens = { showReferencesNotification = true },
                    -- not supported - https://github.com/neovim/neovim/pull/15723
                    semanticTokens = false,
                    diagnostics = true,
                },
            },
        }),
    }

    lspconfig_configs.volar_html = {
        default_config = vim.tbl_extend("keep", volar_common, {
            filetypes = filetypes,
            init_options = {
                typescript = {
                    serverPath = "",
                },
                documentFeatures = {
                    selectionRange = true,
                    foldingRange = true,
                    linkedEditingRange = true,
                    documentSymbol = true,
                    -- not supported - https://github.com/neovim/neovim/pull/13654
                    documentColor = true,
                    -- documentFormatting = {
                    --   defaultPrintWidth = 80,
                    --   getDocumentPrintWidthRequest = 80
                    -- },
                },
            },
            -- handlers = {
            --     ["textDocument/documentColor"] = require("my.plugins.lsp.color").on_document_color,
            -- },
        }),
    }
end

function M.get_typescript_server_path(root_dir)
    local project_root = lspconfig_util.find_node_modules_ancestor(root_dir)
    local local_tsserverlib = project_root ~= nil
        and lspconfig_util.path.join(
            project_root,
            "node_modules",
            "typescript",
            "lib",
            "tsserverlibrary.js"
        )
    local global_tsserverlib = vim.fn.stdpath("data")
        .. "/mason/packages/vue-language-server/node_modules/typescript/lib/tsserverlibrary.js"
    if local_tsserverlib and lspconfig_util.path.exists(local_tsserverlib) then
        return local_tsserverlib
    else
        return global_tsserverlib
    end
end

function M.on_new_config(new_config, new_root_dir)
    new_config.init_options.typescript.serverPath = M.get_typescript_server_path(new_root_dir)
end

return M
