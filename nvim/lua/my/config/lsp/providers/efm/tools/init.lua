return {
    -- python
    flake8 = require("my.config.lsp.providers.efm.tools.flake8"),
    mypy = require("my.config.lsp.providers.efm.tools.mypy"),
    pydocstyle = require("my.config.lsp.providers.efm.tools.pydocstyle"),
    black = require("my.config.lsp.providers.efm.tools.black"),
    isort = require("my.config.lsp.providers.efm.tools.isort"),
    -- lua
    stylua = require("my.config.lsp.providers.efm.tools.stylua"),
    -- sh
    shfmt = require("my.config.lsp.providers.efm.tools.shfmt"),
    shellcheck = require("my.config.lsp.providers.efm.tools.shellcheck"),
    -- javascript react, vue, json, html, css, yaml
    prettier = require("my.config.lsp.providers.efm.tools.prettierd"),
    eslint = require("my.config.lsp.providers.efm.tools.eslint_d"),
    -- markdown
    -- markdownlint = require("config.lsp.providers.efm.tools.markdownlint"),
    pandoc = require("my.config.lsp.providers.efm.tools.pandoc"),
}
