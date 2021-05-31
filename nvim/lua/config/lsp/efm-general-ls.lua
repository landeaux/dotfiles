-- Example configuations here: https://github.com/mattn/efm-langserver
-- TODO this file needs to be refactored eache lang should be it's own file
-- python
local python_arguments = {}

-- TODO replace with path argument
local flake8 = {
    lintCommand = "flake8 --ignore=E501 --stdin-display-name ${INPUT} -",
    lintStdin = true,
    lintFormats = {"%f:%l:%c: %m"}
}

local pydocstyle = {
    lintCommand = "pydocstyle --convention=numpy ${INPUT}",
    lintFormats = {"%I%f:%l %.%#:", "%Z%*\\sD%n: %m"}
}

local isort = {formatCommand = "isort --stdout --profile black -", formatStdin = true}

local black = {formatCommand = "black --fast --quiet -", formatStdin = true}

-- local mypy = {
--     lintCommand = "mypy --show-column-numbers --ignore-missing-imports",
--     lintFormats = {"%f:%l:%c: %trror: %m", "%f:%l:%c: %tarning: %m", "%f:%l:%c: %tote: %m"},
--     lintSource = "mypy"
-- }

table.insert(python_arguments, flake8)
table.insert(python_arguments, pydocstyle)
table.insert(python_arguments, isort)
table.insert(python_arguments, black)
-- table.insert(python_arguments, mypy)

-- lua
local lua_arguments = {}
local lua_formatter = "lua-format"

local luaFormat = {
    formatCommand = [[
        lua-format -i \
        --column-limit=100 \
        --no-keep-simple-function-one-line \
        --break-after-table-lb \
        --break-before-table-rb \
        --break-after-functiondef-lp \
        --break-before-functiondef-rp \
        --break-after-functioncall-lp \
        --break-before-functioncall-rp \
        --chop-down-parameter \
        --chop-down-table \
        --chop-down-kv-table
    ]],
    formatStdin = true
}

local lua_fmt = {
    formatCommand = "luafmt --indent-count 2 --line-width 100 --stdin",
    formatStdin = true
}

if lua_formatter == "lua-format" then
    table.insert(lua_arguments, luaFormat)
elseif lua_formatter == "lua-fmt" then
    table.insert(lua_arguments, lua_fmt)
end

-- sh
local sh_arguments = {}

local shfmt = {formatCommand = "shfmt -ci -s -bn", formatStdin = true}

local shellcheck = {
    LintCommand = "shellcheck -f gcc -x",
    lintFormats = {"%f:%l:%c: %trror: %m", "%f:%l:%c: %tarning: %m", "%f:%l:%c: %tote: %m"}
}

table.insert(sh_arguments, shfmt)
table.insert(sh_arguments, shellcheck)

-- tsserver/web javascript react, vue, json, html, css, yaml
local prettier = {
    formatCommand = [[
		./node_modules/.bin/prettier \
            --semi false \
            --single-quote true \
            --tab-width 2 \
            --trailing-comma es5 \
            --stdin-filepath ${INPUT}
	]],
    formatStdin = true
}

-- local prettier = {
--     formatCommand = [[
--         prettier_d_slim \
--             --semi false \
--             --single-quote true \
--             --tab-width 2 \
--             --trailing-comma es5 \
--             --stdin --stdin-filepath ${INPUT}
--     ]],
--     formatStdin = true
-- }

-- You can look for project scope Prettier and Eslint with e.g. vim.fn.glob("node_modules/.bin/prettier") etc. If it is not found revert to global Prettier where needed.

local eslint = {
    -- lintCommand = "./node_modules/.bin/eslint -f unix --stdin --stdin-filename ${INPUT}",
    lintCommand = "eslint_d -f visualstudio --stdin --stdin-filename ${INPUT}",
    lintIgnoreExitCode = true,
    lintStdin = true,
    lintFormats = {"%f(%l,%c): %tarning %m", "%f(%l,%c): %rror %m"},
    -- formatCommand = "./node_modules/.bin/eslint --fix-to-stdout --stdin --stdin-filename=${INPUT}",
    formatCommand = "eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}",
    formatStdin = true
}

local tsserver_args = {}

table.insert(tsserver_args, prettier)
table.insert(tsserver_args, eslint)

local vue_args = {}

table.insert(vue_args, prettier)
table.insert(vue_args, eslint)

-- local markdownlint = {
--     -- TODO default to global lintrc
--     -- lintcommand = 'markdownlint -s -c ./markdownlintrc',
--     lintCommand = 'markdownlint -s',
--     lintStdin = true,
--     lintFormats = {'%f:%l %m', '%f:%l:%c %m', '%f: %l: %m'}
-- }

local markdownPandocFormat = {
    formatCommand = "pandoc -f markdown -t gfm -sp --tab-stop=2",
    formatStdin = true
}

local on_attach = function(client, bufnr)
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end

    -- Mappings.
    local opts = {noremap = true, silent = true}
    buf_set_keymap("n", "<space>lf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

    -- Format on save
    require("utils").create_augroup(
        {{"BufWritePre", "*", "lua vim.lsp.buf.formatting_sync(nil, 1000)"}}, "lsp_auto_format"
    )

    local keys = {l = {name = "+lsp", f = "Format"}}

    require("whichkey_setup").register_keymap("leader", keys)
end

require"lspconfig".efm.setup {
    on_attach = on_attach,
    cmd = {vim.fn.stdpath("data") .. "/lspinstall/efm/efm-langserver"},
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
        rootMarkers = {".git/"},
        languages = {
            python = python_arguments,
            lua = lua_arguments,
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

-- Also find way to toggle format on save
-- maybe this will help: https://superuser.com/questions/439078/how-to-disable-autocmd-or-augroup-in-vim
