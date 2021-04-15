-- Tree-sitter
require'nvim-treesitter.configs'.setup {
    ensure_installed = {'python', 'bash', 'lua', 'toml'},
    highlight = {
        enable = true,
        disable = {},
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
        }
    },
    indent = {
        enable = true
    },
    textobjects = {
        select = {
            enable = true,
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",

                ["iF"] = {
                    python = "(function_definition) @function",
                },
            },
        },
    },
    context_commentstring = {
        enable = true,
        config = {
            vue = {
                style_element = '// %s'
            }
        }
    }
}
