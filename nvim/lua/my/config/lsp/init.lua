-- General LSP settings
require("my.config.lsp.nvim-lsp-settings")

-- Individual language server configs
require("my.config.lsp.bash-ls")
require("my.config.lsp.css-ls")
require("my.config.lsp.docker-ls")
require("my.config.lsp.html-ls")
require("my.config.lsp.lua-ls")
require("my.config.lsp.js-ts-ls")
require("my.config.lsp.json-ls")
require("my.config.lsp.php-ls")
require("my.config.lsp.python-ls")
require("my.config.lsp.vim-ls")
require("my.config.lsp.vue-ls")
require("my.config.lsp.yaml-ls")

-- General language server for formatting and linting
require("my.config.lsp.efm-ls")

-- Diagnostics
require("my.config.lsp.diagnostics")

-- LSP plugin config
require("my.config.lsp.nvim-cmp")
require("my.config.lsp.luasnip")
require("my.config.lsp.nvim-lightbulb")
