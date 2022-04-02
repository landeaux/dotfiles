require("my.config.lsp.providers.volar")

-- vim.lsp.set_log_level("trace")
-- require("vim.lsp.log").set_format_func(vim.inspect)

local default_config = require("my.config.lsp.providers.defaults")
local lsp_installer = require("nvim-lsp-installer")

lsp_installer.settings({
    ui = {
        keymaps = {
            -- Keymap to expand a server in the UI
            toggle_server_expand = "i",
            -- Keymap to install a server
            install_server = "<CR>",
            -- Keymap to reinstall/update a server
            update_server = "u",
            -- Keymap to uninstall a server
            uninstall_server = "x",
        },
    },
})

-- initial default servers
local requested_servers = {
    "bashls",
    "cssls",
    "dockerls",
    -- "eslint",
    "html",
    "jsonls",
    "sumneko_lua",
    "tsserver",
    "taplo",
    "intelliphense",
    "pyright",
    "vimls",
    -- "volar", -- NOTE: This can't exist alongside vuels
    -- "vuels",
    "yamlls",
    "prosemd_lsp",
}

-- go through requested_servers and ensure installation
local lsp_installer_servers = require("nvim-lsp-installer.servers")
for _, requested_server in pairs(requested_servers) do
    local ok, server = lsp_installer_servers.get_server(requested_server)
    if ok then
        if not server:is_installed() then
            server:install()
        end
    end
end

lsp_installer.on_server_ready(function(server)
    if server.name == "volar" then
        return
    end

    local opts = default_config

    opts.autostart = true

    local custom_config_path = "my.config.lsp.providers." .. server.name
    local custom_config_exists, config = pcall(require, custom_config_path)
    if custom_config_exists then
        opts = vim.tbl_deep_extend("force", opts, config)
    end

    -- This setup() function is exactly the same as lspconfig's setup function (:help lspconfig-quickstart)
    server:setup(opts)

    vim.cmd([[ do User LspAttachBuffers ]])
end)

require("my.config.lsp.providers.volar").register_volar_lspconfigs()

local lspconfig = require("lspconfig")

lspconfig.volar_api.setup(default_config)
lspconfig.volar_doc.setup(default_config)
lspconfig.volar_html.setup(default_config)
