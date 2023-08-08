local opt = vim.opt

-- Enable folding
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldlevel = 99

-- Tree-sitter
require("nvim-treesitter.configs").setup({
    autotag = {
        enable = true,
        filetypes = {
            "html",
            "javascript",
            "javascriptreact",
            "jsx",
            "markdown",
            "php",
            "smarty",
            "svelte",
            "tsx",
            "typescript",
            "typescriptreact",
            "vue",
        },
    },
    auto_install = true,
    ensure_installed = {
        "bash",
        "comment",
        "css",
        "dockerfile",
        "gitignore",
        "html",
        "javascript",
        "jsdoc",
        "json",
        "lua",
        "make",
        "markdown",
        "markdown_inline",
        "php",
        -- "phpdoc", -- TODO: check this out
        "python",
        "query",
        "regex",
        "rst",
        "scss",
        "sql",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vue",
        "yaml",
    },
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    indent = {
        enable = true,
        disable = { "python" },
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<CR>",
            node_incremental = "<CR>",
            scope_incremental = "<S-CR>",
            node_decremental = "<BS>",
        },
    },
    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
                ["al"] = "@loop.outer",
                ["il"] = "@loop.inner",
                ["ai"] = "@conditional.outer",
                ["ii"] = "@conditional.inner",
                ["a/"] = "@comment.outer",
            },
        },
        swap = {
            enable = true,
            swap_next = { ["<leader>>"] = "@parameter.inner" },
            swap_previous = { ["<leader><"] = "@parameter.inner" },
        },
        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = { ["]m"] = "@function.outer", ["]]"] = "@class.outer" },
            goto_next_end = { ["]M"] = "@function.outer", ["]["] = "@class.outer" },
            goto_previous_start = { ["[m"] = "@function.outer", ["[["] = "@class.outer" },
            goto_previous_end = { ["[M"] = "@function.outer", ["[]"] = "@class.outer" },
        },
        lsp_interop = {
            enable = true,
            border = "rounded",
            peek_definition_code = {
                ["<leader>lp"] = "@function.outer",
                ["<leader>lP"] = "@class.outer",
            },
        },
    },
    context_commentstring = { enable = true, enable_autocmd = false },
})

require("nvim-treesitter.parsers").get_parser_configs().smarty = {
    install_info = {
        url = "https://github.com/Kibadda/tree-sitter-smarty",
        files = { "src/parser.c", "src/scanner.cc" },
        branch = "master",
    },
    filetype = "smarty",
}
