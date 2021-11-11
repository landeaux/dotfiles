local wk = require("whichkey_setup")
local opt = vim.opt

-- Enable folding
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldlevel = 99

-- Tree-sitter
require("nvim-treesitter.configs").setup({
    autotag = {
        enable = true,
    },
    ensure_installed = {
        "bash",
        "c",
        "comment",
        "cpp",
        "css",
        "dockerfile",
        "graphql",
        "html",
        "javascript",
        "jsdoc",
        "json",
        "latex",
        "lua",
        "php",
        "python",
        "r",
        "regex",
        "rst",
        "scss",
        "toml",
        "tsx",
        "typescript",
        "vue",
        "yaml",
    },
    highlight = { enable = true, disable = {} },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "gli",
            node_incremental = "glj",
            scope_incremental = "gll",
            node_decremental = "glk",
        },
    },
    textobjects = {
        select = {
            enable = true,
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",

                ["iF"] = { python = "(function_definition) @function" },
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
    },
    context_commentstring = { enable = true, enable_autocmd = false },
})

-- custom md
local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.markdown = {
    install_info = {
        url = "https://github.com/ikatyang/tree-sitter-markdown",
        files = { "src/parser.c", "src/scanner.cc" },
    },
    filetype = "md",
}

local keymap_g = { name = "+goto", l = { name = "+ts-selection", i = "Initialize selection" } }

wk.register_keymap("g", keymap_g)

local keymap_leader = { [">"] = "TS: Swap next parameter", ["<"] = "TS: Swap previous parameter" }

wk.register_keymap("leader", keymap_leader)
