-- vim.lsp.set_log_level("debug")
-- require("vim.lsp.log").set_format_func(vim.inspect)

local ensure_installed = {
    "ansiblels",
    "basedpyright",
    "bashls",
    "cssls",
    "dockerls",
    "gopls",
    "html",
    "jsonls",
    "prosemd_lsp",
    -- "ruff_lsp",
    "lua_ls",
    "taplo",
    "tailwindcss",
    "vimls",
    "volar",
    "vtsls",
    "yamlls",
}

require("mason-lspconfig").setup({
    automatic_installation = false,
    ensure_installed = ensure_installed,
})

local servers = vim.list_extend({
    "intelephense",
    "ruff",
    "smarty_ls",
}, ensure_installed)

local default_config = require("my.plugins.lsp.providers.defaults")
local lspconfig = require("lspconfig")

for _, server in pairs(servers) do
    local opts = default_config

    local custom_config_path = "my.plugins.lsp.providers." .. server
    local custom_config_exists, config = pcall(require, custom_config_path)

    if custom_config_exists then
        opts = vim.tbl_deep_extend("force", opts, config)
    end

    lspconfig[server].setup(opts)
end
