return {
    "stevearc/conform.nvim",
    init = function()
        require("my.plugins.conform-nvim.mappings")
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
    opts = {
        formatters_by_ft = {
            ["_"] = { "trim_whitespace" },
            ["markdown.mdx"] = { "prettierd" },
            css = { "prettierd" },
            graphql = { "prettierd" },
            handlebars = { "prettierd" },
            html = { "prettierd" },
            javascript = { "prettierd", "eslint_d" },
            javascriptreact = { "prettierd", "eslint_d" },
            json = { "prettierd" },
            jsonc = { "prettierd" },
            less = { "prettierd" },
            lua = { "stylua" },
            markdown = { "prettierd" },
            php = { "php_cs_fixer" },
            python = { "isort", "black" },
            scss = { "prettierd" },
            sh = { "shfmt" },
            typescript = { "prettierd", "eslint_d" },
            typescriptreact = { "prettierd", "eslint_d" },
            vue = { "prettierd", "eslint_d" },
            yaml = { "prettierd" },
        },
    },
    config = function(_, opts)
        local util = require("conform.util")
        util.add_formatter_args(require("conform.formatters.shfmt"), { "-i", "2" })
        require("conform").setup(opts)
    end,
}
