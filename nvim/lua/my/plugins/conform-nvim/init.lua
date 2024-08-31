return {
    "stevearc/conform.nvim",
    init = function() vim.o.formatexpr = "v:lua.require'conform'.formatexpr()" end,
    cmd = { "ConformInfo", "Format" },
    keys = {
        { "<Leader>lf", ":Format<CR>", mode = "", desc = "Format" },
    },
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
            markdown = { "prettierd", "injected" },
            php = { "php_cs_fixer" },
            python = function(bufnr)
                if require("conform").get_formatter_info("ruff_format", bufnr).available then
                    return { "ruff_organize_imports", "ruff_format" }
                else
                    return { "isort", "black" }
                end
            end,
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

        vim.api.nvim_create_user_command("Format", function(args)
            local range = nil
            if args.count ~= -1 then
                local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
                range = {
                    start = { args.line1, 0 },
                    ["end"] = { args.line2, end_line:len() },
                }
            end
            require("conform").format({ async = true, lsp_format = "fallback", range = range }, function(err)
                if not err then
                    local mode = vim.api.nvim_get_mode().mode
                    if vim.startswith(string.lower(mode), "v") then
                        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
                    end
                end
            end)
        end, { range = true })
    end,
}
