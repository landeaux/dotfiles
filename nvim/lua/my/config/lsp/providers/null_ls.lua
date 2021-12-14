local on_attach = require("my.config.lsp.providers.defaults").on_attach
local null_ls = require("null-ls")

null_ls.setup({
    -- debug = true,
    sources = {
        -- Code Actions
        null_ls.builtins.code_actions.eslint_d,
        null_ls.builtins.code_actions.shellcheck,
        -- Diagnostics
        null_ls.builtins.diagnostics.eslint_d,
        null_ls.builtins.diagnostics.flake8,
        null_ls.builtins.diagnostics.markdownlint,
        null_ls.builtins.diagnostics.mypy,
        null_ls.builtins.diagnostics.shellcheck,
        -- Formatting
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.isort,
        null_ls.builtins.formatting.phpcsfixer,
        null_ls.builtins.formatting.prettierd,
        null_ls.builtins.formatting.shfmt,
        null_ls.builtins.formatting.stylua,
    },
    on_attach = on_attach,
})

local pydocstyle = {
    method = null_ls.methods.DIAGNOSTICS,
    filetypes = { "python" },
    generator = null_ls.generator({
        runtime_condition = function(params)
            local fname = vim.fn.fnamemodify(params.bufname, ":t:r")
            return not vim.startswith(fname, "test_")
        end,
        command = "pydocstyle",
        args = {
            -- Default config discovery ignores CWD and uses the directory the temp-file is in.
            -- we want to use the config in the project.
            "--config=$ROOT/pyproject.toml",
            -- pydocstyle doesn't support receiving the file via STDIN
            "$FILENAME",
        },
        to_stdin = false,
        to_temp_file = true,
        format = "raw",
        check_exit_code = function(code)
            return code <= 1
        end,
        on_output = function(params, done)
            local output = params.output
            if not output then
                return done()
            end

            -- pydocstyle output is in two lines for each error,
            -- which is why we cannot use `format = "line"` and have to
            -- split lines on our own.
            --
            -- Example:
            --     nsync/tasks.py:48 in public function `send_stored_draft`:
            --         D403: First word of the first line should be properly capitalized ('Send', not 'send')

            local diagnostics = {}
            local current_line = nil

            for _, line in ipairs(vim.split(output, "\n")) do
                if line ~= "" then
                    if current_line == nil then
                        current_line = tonumber(line:match(":(%d+) "))
                    else
                        local code, message = line:match("%s+(D%d+): (.*)")

                        table.insert(diagnostics, {
                            row = current_line,
                            source = "pydocstyle(" .. code .. ")",
                            message = message,
                            severity = 3, -- "info" severity
                        })

                        current_line = nil
                    end
                end
            end
            done(diagnostics)
        end,
    }),
}

null_ls.register(pydocstyle)
