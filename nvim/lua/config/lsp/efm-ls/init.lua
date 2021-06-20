-- python
local python_args = {}

local flake8 = require "config.lsp.efm-ls.linters.flake8"
local mypy = require "config.lsp.efm-ls.linters.mypy"
local pydocstyle = require "config.lsp.efm-ls.linters.pydocstyle"

local black = require "config.lsp.efm-ls.formatters.black"
local isort = require "config.lsp.efm-ls.formatters.isort"

table.insert(python_args, flake8)
table.insert(python_args, mypy)
table.insert(python_args, pydocstyle)
table.insert(python_args, black)
table.insert(python_args, isort)

-- lua
local lua_args = {}

local lua_formatter = "lua-format"

local lua_format = require "config.lsp.efm-ls.formatters.lua-format"
local luafmt = require "config.lsp.efm-ls.formatters.luafmt"

if lua_formatter == "lua-format" then
    table.insert(lua_args, lua_format)
elseif lua_formatter == "lua-fmt" then
    table.insert(lua_args, luafmt)
end

-- sh
local sh_arguments = {}

local shfmt = require "config.lsp.efm-ls.formatters.shfmt"
local shellcheck = require "config.lsp.efm-ls.linters.shellcheck"

table.insert(sh_arguments, shfmt)
table.insert(sh_arguments, shellcheck)

-- javascript react, vue, json, html, css, yaml
-- local prettier = require "config.lsp.efm-ls.formatters.prettier"
-- local prettier = require "config.lsp.efm-ls.formatters.prettier_d_slim"
local prettier = require "config.lsp.efm-ls.formatters.prettierd"

-- local eslint = require "config.lsp.efm-ls.linters.eslint"
local eslint = require "config.lsp.efm-ls.linters.eslint_d"

local tsserver_args = {}

table.insert(tsserver_args, prettier)
table.insert(tsserver_args, eslint)

local vue_args = {}

table.insert(vue_args, prettier)
table.insert(vue_args, eslint)

-- markdown
-- local markdownlint = require "config.lsp.efm-ls.linters.markdownlint"
local markdownPandocFormat = require "config.lsp.efm-ls.formatters.pandoc"

local on_attach = function(client, bufnr)
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end

    -- Mappings
    local opts = {noremap = true, silent = true}
    buf_set_keymap("n", "<space>lf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

    -- Format on save
    require("utils").create_augroup(
        {{"BufWritePre", "*", "lua vim.lsp.buf.formatting_sync(nil, 1000)"}}, "lsp_auto_format"
    )
    -- Also find way to toggle format on save
    -- maybe this will help: https://superuser.com/questions/439078/how-to-disable-autocmd-or-augroup-in-vim

    local keys = {l = {name = "+lsp", f = "Format"}}

    require("whichkey_setup").register_keymap("leader", keys)
end

local efm_config = os.getenv("HOME") .. "/.config/efm-langserver/config.yaml"

require"lspconfig".efm.setup {
    on_attach = on_attach,
    cmd = {
        vim.fn.stdpath("data") .. "/lspinstall/efm/efm-langserver",
        "-c",
        efm_config
    },
    init_options = {documentFormatting = true, codeAction = false},
    filetypes = {
        "lua",
        "python",
        "javascriptreact",
        "javascript",
        "sh",
        "html",
        "css",
        "json",
        "yaml",
        "markdown",
        "vue"
    },
    settings = {
        rootMarkers = {"package.json", ".git"},
        languages = {
            python = python_args,
            lua = lua_args,
            sh = sh_arguments,
            javascript = tsserver_args,
            javascriptreact = tsserver_args,
            html = {prettier},
            css = {prettier},
            json = {prettier},
            yaml = {prettier},
            vue = vue_args,
            markdown = {markdownPandocFormat}
        }
    }
}
