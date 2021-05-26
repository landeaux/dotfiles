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
        }
    }
    -- context_commentstring = {
    --     enable = true,
    --     config = {
    --         vue = {
    --             style_element = '// %s'
    --         }
    --     }
    -- }
}
