-- vim.lsp.set_log_level("debug")
-- require("vim.lsp.log").set_format_func(vim.inspect)

-- IMPORTANT: make sure to setup neodev BEFORE lspconfig
require("neodev").setup({
    -- add any options here, or leave empty to use the default settings
})

require("mason-lspconfig").setup({
    ensure_installed = {
        "bashls",
        "cssls",
        "dockerls",
        "html",
        "intelephense",
        "jsonls",
        "prosemd_lsp",
        "pyright",
        "rust_analyzer",
        "lua_ls",
        "tailwindcss",
        "taplo",
        "tsserver",
        "vimls",
        "volar",
        "yamlls",
    },
})

local servers = {
    "bashls",
    "cssls",
    "dockerls",
    "html",
    "intelephense",
    "jsonls",
    "prosemd_lsp",
    "pyright",
    "rust_analyzer",
    "smarty_ls",
    "lua_ls",
    "tailwindcss",
    "taplo",
    "tsserver",
    "vimls",
    "volar",
    "yamlls",
}

-- require("my.plugins.lsp.providers.volar_multi").register_volar_lspconfigs()

local lspconfig = require("lspconfig")
local default_config = require("my.plugins.lsp.providers.defaults")

for _, server in pairs(servers) do
    local opts = default_config

    local custom_config_path = "my.plugins.lsp.providers." .. server
    local custom_config_exists, config = pcall(require, custom_config_path)

    if custom_config_exists then
        opts = vim.tbl_deep_extend("force", opts, config)
    end

    -- if server == "volar" then
    --     lspconfig.volar_doc.setup(opts)
    --     lspconfig.volar_api.setup(opts)
    --     lspconfig.volar_html.setup(opts)
    if server == "tsserver" then
        require("typescript").setup({
            disable_commands = false, -- prevent the plugin from creating Vim commands
            debug = false, -- enable debug logging for commands
            server = opts, -- pass options to lspconfig's setup method
        })
    else
        lspconfig[server].setup(opts)
    end
end
