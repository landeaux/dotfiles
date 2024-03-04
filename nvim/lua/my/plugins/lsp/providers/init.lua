-- vim.lsp.set_log_level("debug")
-- require("vim.lsp.log").set_format_func(vim.inspect)

-- IMPORTANT: make sure to setup neodev BEFORE lspconfig
require("neodev").setup({
    -- add any options here, or leave empty to use the default settings
})

local ensure_installed = {
    "ansiblels",
    "bashls",
    "cssls",
    "dockerls",
    "html",
    "jsonls",
    "prosemd_lsp",
    "pyright",
    "lua_ls",
    "taplo",
    "tsserver",
    "vimls",
    "volar",
    "yamlls",
}

require("mason-lspconfig").setup({
    ensure_installed = ensure_installed,
})

local servers = vim.list_extend({
    "intelephense",
    "smarty_ls",
}, ensure_installed)

local lspconfig = require("lspconfig")
local default_config = require("my.plugins.lsp.providers.defaults")

for _, server in pairs(servers) do
    local opts = default_config

    local custom_config_path = "my.plugins.lsp.providers." .. server
    local custom_config_exists, config = pcall(require, custom_config_path)

    if custom_config_exists then
        opts = vim.tbl_deep_extend("force", opts, config)
    end

    lspconfig[server].setup(opts)
end
