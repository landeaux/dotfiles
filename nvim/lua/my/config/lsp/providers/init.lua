local default_config = require("my.config.lsp.providers.defaults")
local lsp_installer = require("nvim-lsp-installer")
local lspconfig = require("lspconfig")

-- vim.lsp.set_log_level("trace")
-- require("vim.lsp.log").set_format_func(vim.inspect)

-- initial default servers
local servers = {
    "awk_ls",
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

lsp_installer.setup({
    ensure_installed = servers,
    log_level = vim.log.levels.INFO,
    -- log_level = vim.log.levels.DEBUG,
})

require("my.config.lsp.providers.volar").register_volar_lspconfigs()

for _, server in pairs(servers) do
    local opts = default_config

    opts.autostart = true

    local custom_config_path = "my.config.lsp.providers." .. server
    local custom_config_exists, config = pcall(require, custom_config_path)

    if custom_config_exists then
        opts = vim.tbl_deep_extend("force", opts, config)
    end

    if server == "volar" then
        lspconfig.volar_api.setup(opts)
        lspconfig.volar_doc.setup(opts)
        lspconfig.volar_html.setup(opts)
    else
        lspconfig[server].setup(opts)
    end
end
