local tools = require("my.config.lsp.providers.efm.tools")

return {
    init_options = { documentFormatting = true, codeAction = true },
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
            css = { tools.prettier },
            html = { tools.prettier },
            javascript = {
                tools.prettier,
                tools.eslint,
            },
            javascriptreact = {
                tools.prettier,
                tools.eslint,
            },
            json = { tools.prettier },
            lua = { tools.stylua },
            markdown = {
                tools.markdownlint,
                tools.pandoc,
            },
            python = {
                tools.flake8,
                tools.mypy,
                tools.pydocstyle,
                tools.black,
                tools.isort,
            },
            sh = {
                tools.shfmt,
                tools.shellcheck,
            },
            vue = {
                tools.prettier,
                tools.eslint,
            },
            yaml = { tools.prettier },
        },
    },
}
