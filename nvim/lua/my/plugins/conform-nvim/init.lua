return {
    "stevearc/conform.nvim",
    init = function() vim.o.formatexpr = "v:lua.require'conform'.formatexpr()" end,
    event = { "BufWritePre" },
    cmd = { "ConformInfo", "Format", "FormatEnable", "FormatDisable" },
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
            toml = { lsp_format = "prefer" },
            typescript = { "prettierd", "eslint_d" },
            typescriptreact = { "prettierd", "eslint_d" },
            vue = { "prettierd", "eslint_d" },
            yaml = { "prettierd" },
        },
        format_on_save = function(bufnr)
            -- Disable with a global or buffer-local variable
            if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                return
            end
            return { timeout_ms = 500, lsp_format = "fallback" }
        end,
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

        vim.api.nvim_create_user_command("FormatDisable", function(args)
            if args.bang then
                -- FormatDisable! will disable formatting just for this buffer
                vim.b.disable_autoformat = true
            else
                vim.g.disable_autoformat = true
            end
        end, {
            desc = "Disable autoformat-on-save",
            bang = true,
        })

        vim.api.nvim_create_user_command("FormatEnable", function()
            vim.b.disable_autoformat = false
            vim.g.disable_autoformat = false
        end, {
            desc = "Re-enable autoformat-on-save",
        })
    end,
}
