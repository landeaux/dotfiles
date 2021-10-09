-- General LSP settings
require("plugins.config.lsp.nvim-lsp-settings")

-- Individual language server configs
require("plugins.config.lsp.bash-ls")
require("plugins.config.lsp.css-ls")
require("plugins.config.lsp.docker-ls")
require("plugins.config.lsp.html-ls")
require("plugins.config.lsp.lua-ls")
require("plugins.config.lsp.js-ts-ls")
require("plugins.config.lsp.json-ls")
require("plugins.config.lsp.php-ls")
require("plugins.config.lsp.python-ls")
require("plugins.config.lsp.vim-ls")
require("plugins.config.lsp.vue-ls")
require("plugins.config.lsp.yaml-ls")

-- General language server for formatting and linting
require("plugins.config.lsp.efm-ls")

-- Diagnostics
require("plugins.config.lsp.diagnostics")

-- LSP plugin config
require("plugins.config.lsp.nvim-cmp")
require("plugins.config.lsp.luasnip")
require("plugins.config.lsp.nvim-lightbulb")
