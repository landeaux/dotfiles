local wk = require("which-key")
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
        "make",
        "markdown",
        "markdown_inline",
        "php",
        -- "phpdoc", -- TODO: check this out
        "python",
        "r",
        "regex",
        "rst",
        "scss",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vue",
        "yaml",
    },
    highlight = {
        enable = true,
        -- disable = {},
        -- additional_vim_regex_highlighting = {
        --     "javascript",
        -- },
    },
    -- indent = {
    --     enable = true,
    -- },
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
                ["<leader>lpf"] = "@function.outer",
                ["<leader>lpc"] = "@class.outer",
            },
        },
    },
    context_commentstring = { enable = true, enable_autocmd = false },
})

local keymap_g = { name = "+goto", l = { name = "+ts-selection", i = "Initialize selection" } }

wk.register(keymap_g, { prefix = "g" })

local keymap_leader = {
    [">"] = "TS: Swap next parameter",
    ["<"] = "TS: Swap previous parameter",
    l = {
        name = "+lsp",
        p = {
            name = "+peek_definition_code",
            f = "Peek funtion definition",
            c = "Peek class definition",
        },
    },
}

wk.register(keymap_leader, { prefix = "<leader>" })
