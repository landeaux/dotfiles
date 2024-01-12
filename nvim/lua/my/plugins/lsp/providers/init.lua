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
    "intelephense",
    "jsonls",
    "prismals",
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
}

require("mason-lspconfig").setup({
    ensure_installed = ensure_installed,
})

local servers = vim.list_extend(ensure_installed, {
    "smarty_ls",
})

local lspconfig = require("lspconfig")
local default_config = require("my.plugins.lsp.providers.defaults")
local enable_volar_takeover_mode = vim.g.volar_takeover_mode and require("my.utils").is_vue_project()

for _, server in pairs(servers) do
    local opts = default_config

    local custom_config_path = "my.plugins.lsp.providers." .. server
    local custom_config_exists, config = pcall(require, custom_config_path)

    if custom_config_exists then
        opts = vim.tbl_deep_extend("force", opts, config)
    end

    if enable_volar_takeover_mode then
        if server == "tsserver" then
            goto continue
        elseif server == "volar" then
            opts.filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" }
        end
    end

    if server == "tsserver" then
        require("typescript").setup({
            disable_commands = false, -- prevent the plugin from creating Vim commands
            debug = false, -- enable debug logging for commands
            server = opts, -- pass options to lspconfig's setup method
        })
    else
        lspconfig[server].setup(opts)
    end

    ::continue::
end
