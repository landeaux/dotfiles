-- Tree-sitter
require'nvim-treesitter.configs'.setup {
    ensure_installed = {
        'bash',
        'comment',
        'css',
        'graphql',
        'html',
        'javascript',
        'json',
        'lua',
        'python',
        'scss',
        'toml',
        'typescript',
        'vue',
        'yaml'
    },
    highlight = {enable = true, disable = {}},
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "gli",
            node_incremental = "glj",
            scope_incremental = "gll",
            node_decremental = "glk"
        }
    },
    textobjects = {
        select = {
            enable = true,
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",

                ["iF"] = {python = "(function_definition) @function"}
            }
        },
        swap = {
            enable = true,
            swap_next = {["<leader>>"] = "@parameter.inner"},
            swap_previous = {["<leader><"] = "@parameter.inner"}
        },
        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {["]m"] = "@function.outer", ["]]"] = "@class.outer"},
            goto_next_end = {["]M"] = "@function.outer", ["]["] = "@class.outer"},
            goto_previous_start = {["[m"] = "@function.outer", ["[["] = "@class.outer"},
            goto_previous_end = {["[M"] = "@function.outer", ["[]"] = "@class.outer"}
        }
    },
    context_commentstring = {
        enable = true,
        enable_autocmd = true,
        config = {
            vue = {
                template_element = '<!-- %s -->',
                script_element = '// %s',
                style_element = '// %s'
            }
        }
    }
}
