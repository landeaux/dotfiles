-- General LSP settings
require("config.lsp.nvim-lsp-settings")

-- Individual language server configs
require("config.lsp.bash-ls")
require("config.lsp.css-ls")
require("config.lsp.docker-ls")
require("config.lsp.html-ls")
require("config.lsp.lua-ls")
require("config.lsp.js-ts-ls")
require("config.lsp.json-ls")
require("config.lsp.php-ls")
require("config.lsp.python-ls")
require("config.lsp.vim-ls")
require("config.lsp.vue-ls")
require("config.lsp.yaml-ls")

-- General language server for formatting and linting
require("config.lsp.efm-ls")

-- Diagnostics
require("config.lsp.diagnostics")

-- LSP plugin config
require("config.lsp.nvim-compe")
-- require('config.lsp.lspkind')
require("config.lsp.nvim-lightbulb")
