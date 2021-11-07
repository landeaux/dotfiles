-- python
local python_args = {}

local flake8 = require("my.config.lsp.providers.efm.linters.flake8")
local mypy = require("my.config.lsp.providers.efm.linters.mypy")
local pydocstyle = require("my.config.lsp.providers.efm.linters.pydocstyle")

local black = require("my.config.lsp.providers.efm.formatters.black")
local isort = require("my.config.lsp.providers.efm.formatters.isort")

table.insert(python_args, flake8)
table.insert(python_args, mypy)
table.insert(python_args, pydocstyle)
table.insert(python_args, black)
table.insert(python_args, isort)

-- lua
local lua_args = {}

local lua_formatter = "stylua"

local lua_format = require("my.config.lsp.providers.efm.formatters.lua-format")
local luafmt = require("my.config.lsp.providers.efm.formatters.luafmt")
local stylua = require("my.config.lsp.providers.efm.formatters.stylua")

if lua_formatter == "lua-format" then
    table.insert(lua_args, lua_format)
elseif lua_formatter == "lua-fmt" then
    table.insert(lua_args, luafmt)
elseif lua_formatter == "stylua" then
    table.insert(lua_args, stylua)
end

-- sh
local sh_arguments = {}

local shfmt = require("my.config.lsp.providers.efm.formatters.shfmt")
local shellcheck = require("my.config.lsp.providers.efm.linters.shellcheck")

table.insert(sh_arguments, shfmt)
table.insert(sh_arguments, shellcheck)

-- javascript react, vue, json, html, css, yaml
-- local prettier = require "config.lsp.providers.efm.formatters.prettier"
-- local prettier = require "config.lsp.providers.efm.formatters.prettier_d_slim"
local prettier = require("my.config.lsp.providers.efm.formatters.prettierd")

-- local eslint = require "config.lsp.providers.efm.linters.eslint"
local eslint = require("my.config.lsp.providers.efm.linters.eslint_d")

local tsserver_args = {}

table.insert(tsserver_args, prettier)
table.insert(tsserver_args, eslint)

local vue_args = {}

table.insert(vue_args, prettier)
table.insert(vue_args, eslint)

-- markdown
-- local markdownlint = require "config.lsp.providers.efm.linters.markdownlint"
local markdownPandocFormat = require("my.config.lsp.providers.efm.formatters.pandoc")

local format_on_save = true
local auto_format_lock = false

local on_attach = function(client, bufnr)
    client.resolved_capabilities.document_formatting = true
    client.resolved_capabilities.document_range_formatting = true

    if format_on_save and not auto_format_lock then
        auto_format_lock = true -- just run autocommand once
        -- Format on save
        require("my.utils").create_augroup(
            { { "BufWritePre", "*", "lua vim.lsp.buf.formatting_sync(nil, 1000)" } },
            "lsp_auto_format"
        )
    end

    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end

    -- Mappings
    local opts = { noremap = true, silent = true }
    buf_set_keymap("n", "<space>lf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

    local keys = { l = { name = "+lsp", f = "Format" } }
    require("whichkey_setup").register_keymap("leader", keys)
end

local efm_config = os.getenv("HOME") .. "/.config/efm-langserver/config.yaml"

return {
    init_options = { documentFormatting = true, codeAction = false },
    filetypes = {
        "css",
        "html",
        "javascript",
        "javascriptreact",
        "json",
        "lua",
        "markdown",
        "python",
        "sh",
        "vue",
        "yaml",
    },
    settings = {
        rootMarkers = { "package.json", ".git" },
        languages = {
            css = { prettier },
            html = { prettier },
            javascript = tsserver_args,
            javascriptreact = tsserver_args,
            json = { prettier },
            lua = lua_args,
            markdown = { markdownPandocFormat },
            python = python_args,
            sh = sh_arguments,
            vue = vue_args,
            yaml = { prettier },
        },
    },
    on_attach = on_attach,
}
