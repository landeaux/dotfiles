local default_config = require("my.plugins.lsp.providers.defaults")
local lspconfig = require("lspconfig")

-- vim.lsp.set_log_level("trace")
-- require("vim.lsp.log").set_format_func(vim.inspect)

-- initial default servers
local servers = {
    "bashls",
    "cssls",
    "dockerls",
    -- "eslint",
    "html",
    "jsonls",
    "sumneko_lua",
    "tsserver",
    "taplo",
    "intelephense",
    "pyright",
    "vimls",
    "volar",
    "yamlls",
    "prosemd_lsp",
}

require("mason-lspconfig").setup({
    ensure_installed = servers,
})

require("my.plugins.lsp.providers.volar").register_volar_lspconfigs()

for _, server in pairs(servers) do
    local opts = default_config

    opts.autostart = true

    local custom_config_path = "my.plugins.lsp.providers." .. server
    local custom_config_exists, config = pcall(require, custom_config_path)

    if custom_config_exists then
        opts = vim.tbl_deep_extend("force", opts, config)
    end

    if server == "volar" then
        lspconfig.volar_api.setup(opts)
        lspconfig.volar_doc.setup(opts)
        lspconfig.volar_html.setup(opts)
    elseif server == "tsserver" then
        require("typescript").setup({
            disable_commands = false, -- prevent the plugin from creating Vim commands
            debug = false, -- enable debug logging for commands
            server = opts, -- pass options to lspconfig's setup method
        })
    else
        lspconfig[server].setup(opts)
    end
end