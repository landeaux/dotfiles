-- vim.lsp.set_log_level("debug")
-- require("vim.lsp.log").set_format_func(vim.inspect)

local servers = {
    "ansiblels",
    "basedpyright",
    "bashls",
    "cssls",
    "dockerls",
    "gopls",
    "html",
    "intelephense",
    "jsonls",
    "lua_ls",
    "prosemd_lsp",
    "ruff",
    "smarty_ls",
    "tailwindcss",
    "taplo",
    "twiggy_language_server",
    "vimls",
    "vtsls",
    "vue_ls",
    "yamlls",
}

local default_config = require("my.plugins.lsp.providers.defaults")

for _, server in pairs(servers) do
    local opts = default_config

    local custom_config_path = "my.plugins.lsp.providers." .. server
    local custom_config_exists, config = pcall(require, custom_config_path)

    if custom_config_exists then
        opts = vim.tbl_deep_extend("force", opts, config)
    end

    vim.lsp.config(server, opts)
    vim.lsp.enable(server)
end
