local tools = require("my.config.lsp.providers.efm.tools")

local format_on_save = true
local auto_format_lock = false

local on_attach = function(client, bufnr)
    client.resolved_capabilities.document_formatting = true
    client.resolved_capabilities.document_range_formatting = true

    if format_on_save and not auto_format_lock then
        auto_format_lock = true -- just run autocommand once
        -- Format on save
        require("my.utils").create_augroup(
            { { "BufWritePre", "*", "lua vim.lsp.buf.formatting_sync(nil, 1000)" } },
            "lsp_auto_format"
        )
    end

    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end

    -- Mappings
    local opts = { noremap = true, silent = true }
    buf_set_keymap("n", "<space>lf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

    local keys = { l = { name = "+lsp", f = "Format" } }
    require("whichkey_setup").register_keymap("leader", keys)
end

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
            markdown = { tools.pandoc },
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
    on_attach = on_attach,
}
