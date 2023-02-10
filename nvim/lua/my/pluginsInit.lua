-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
    -- Colorscheme
    {
        "catppuccin/nvim",
        name = "catppuccin",
        config = function()
            require("my.plugins.catppuccin")
        end,
    },

    {
        "rcarriga/nvim-notify",
        config = function()
            require("my.plugins.nvim-notify")
        end,
    },

    -- Neovim icons
    {
        "nvim-tree/nvim-web-devicons",
        config = function()
            require("my.plugins.nvim-web-devicons")
        end,
    },

    {
        "nvim-lualine/lualine.nvim",
        config = function()
            require("my.plugins.lualine")
        end,
        dependencies = { "nvim-tree/nvim-web-devicons", lazy = true },
    },

    -- Tab bar
    {
        "akinsho/bufferline.nvim",
        version = "v3.*",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        init = function()
            require("my.plugins.bufferline.mappings")
        end,
        config = function()
            require("my.plugins.bufferline")
        end,
    },

    -- Indent guides
    {
        "lukas-reineke/indent-blankline.nvim",
        init = function()
            require("my.plugins.indent-blankline.mappings")
        end,
        config = function()
            require("my.plugins.indent-blankline")
        end,
    },

    -- Colorize color codes
    {
        "norcalli/nvim-colorizer.lua",
        init = function()
            require("my.plugins.nvim-colorizer.mappings")
        end,
        config = function()
            require("my.plugins.nvim-colorizer")
        end,
        cmd = {
            "ColorizerAttachToBuffer",
            "ColorizerDetachFromBuffer",
            "ColorizerReloadAllBuffers",
            "ColorizerToggle",
        },
    },

    -- File Tree
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
            {
                -- only needed if you want to use the commands with "_with_window_picker" suffix
                "s1n7ax/nvim-window-picker",
                version = "v1.*",
                config = function()
                    require("my.plugins.window-picker")
                end,
            },
        },
        init = function()
            require("my.plugins.neo-tree.mappings")
        end,
        config = function()
            require("my.plugins.neo-tree")
        end,
        cmd = {
            "Neotree",
        },
    },

    -- Git
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("my.plugins.gitsigns")
        end,
    },
    {
        "tpope/vim-fugitive",
        -- init = function()
        --     require("my.plugins.fugitive.mappings")
        -- end,
        keys = {
            { "<Leader>ga", ":Git add -p<CR>", { desc = "Git add (patch)" } },
            { "<Leader>gb", ":Git blame<CR>", { desc = "Git blame" } },
            { "<Leader>gc", ":Git commit -v<CR>", { desc = "Git commit" } },
            { "<Leader>gd", ":Gdiffsplit<CR>", { desc = "Git diff" } },
            { "<Leader>gm", ":Git commit --amend<CR>", { desc = "Git commit (amend)" } },
            { "<Leader>gp", ":Git push<CR>", { desc = "Git push" } },
            { "<Leader>gs", ":G<CR>", { desc = "Git status" } },
        },
        cmd = {
            "G",
            "GBrowse",
            "GDelete",
            "GMove",
            "GRename",
            "Gdiffsplit",
            "Git",
        },
    },
    {
        "sindrets/diffview.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- optional
        },
        init = function()
            require("my.plugins.diffview-nvim.mappings")
        end,
        config = function()
            require("my.plugins.diffview-nvim")
        end,
        cmd = {
            "DiffviewClose",
            "DiffviewFileHistory",
            "DiffviewFocusFiles",
            "DiffviewLog",
            "DiffviewOpen",
            "DiffviewRefresh",
            "DiffviewToggleFiles",
        },
    },

    -- Floating Terminal
    {
        "numtostr/FTerm.nvim",
        init = function()
            require("my.plugins.fterm.mappings")
        end,
        config = function()
            require("my.plugins.fterm")
        end,
    },

    -- Surround
    "tpope/vim-surround",

    -- Comments
    {
        "numToStr/Comment.nvim",
        config = function()
            require("my.plugins.comment-nvim")
        end,
        keys = { "gc", "gb" },
    },

    -- Remember last location in file
    "farmergreg/vim-lastplace",

    -- UNIX helper
    {
        "tpope/vim-eunuch",
        cmd = {
            "Cfind",
            "Chmod",
            "Clocate",
            "Copy",
            "Delete",
            "Duplicate",
            "Lfind",
            "Llocate",
            "Mkdir",
            "Move",
            "Remove",
            "Rename",
            "SudoEdit",
            "SudoWrite",
            "Wall",
        },
    },

    -- Automatically change current directory
    {
        "airblade/vim-rooter",
        config = function()
            require("my.plugins.rooter")
        end,
    },

    -- Editorconfig
    "editorconfig/editorconfig-vim",

    -- Tooling Installer (LSP servers, formatters, linters, debuggers)
    {
        "williamboman/mason.nvim",
        config = function()
            require("my.plugins.mason")
        end,
    },

    -- LSP
    {
        "neovim/nvim-lspconfig",
        config = function()
            require("my.plugins.lsp")
        end,
        dependencies = {
            "kosayoda/nvim-lightbulb",
            "hrsh7th/cmp-nvim-lsp",
            "jose-elias-alvarez/typescript.nvim",
            "williamboman/mason-lspconfig.nvim",
            "b0o/schemastore.nvim", -- for jsonls
            {
                "mrshmllow/document-color.nvim",
                config = function()
                    require("my.plugins.document-color")
                end,
            },
        },
    },

    {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
            require("my.plugins.lsp.providers.null_ls")
        end,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "neovim/nvim-lspconfig",
            "jose-elias-alvarez/typescript.nvim",
        },
    },

    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("my.plugins.tree-sitter")
        end,
        dependencies = {
            "windwp/nvim-ts-autotag",
            "JoosepAlviste/nvim-ts-context-commentstring",
            "nvim-treesitter/nvim-treesitter-textobjects",
        },
    },

    -- Debugging
    {
        "mfussenegger/nvim-dap",
        init = function()
            require("my.plugins.nvim-dap.mappings")
        end,
        config = function()
            require("my.plugins.nvim-dap")
        end,
    },
    {
        "theHamsta/nvim-dap-virtual-text",
        config = function()
            require("my.plugins.nvim-dap-virtual-text")
        end,
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-treesitter/nvim-treesitter",
        },
    },
    {
        "mfussenegger/nvim-dap-python",
        init = function()
            require("my.plugins.nvim-dap-python.mappings")
        end,
        config = function()
            require("my.plugins.nvim-dap-python")
        end,
        dependencies = { "mfussenegger/nvim-dap" },
    },

    -- Telescope
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        init = function()
            require("my.plugins.telescope-nvim.mappings")
        end,
        config = function()
            require("my.plugins.telescope-nvim")
        end,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-dap.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
            },
        },
    },

    -- Automatic pair insertion
    {
        "windwp/nvim-autopairs",
        config = function()
            require("my.plugins.nvim-autopairs")
        end,
    },

    -- Completion
    {
        "L3MON4D3/LuaSnip",
        config = function()
            require("my.plugins.lsp.luasnip")
        end,
        dependencies = { "rafamadriz/friendly-snippets" },
    },
    {
        "L3MON4D3/LuaSnip",
        version = "v1.*",
        config = function()
            require("my.plugins.lsp.luasnip")
        end,
        dependencies = { "rafamadriz/friendly-snippets" },
        event = "InsertEnter",
    },
    {
        "hrsh7th/nvim-cmp",
        config = function()
            require("my.plugins.lsp.nvim-cmp")
        end,
        dependencies = {
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-calc",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-path",
            "saadparwaiz1/cmp_luasnip",
            "L3MON4D3/LuaSnip",
            "windwp/nvim-autopairs",
        },
        event = "InsertEnter",
    },

    -- Markdown preview
    {
        "iamcco/markdown-preview.nvim",
        build = function()
            vim.fn["mkdp#util#install"]()
        end,
        init = function()
            require("my.plugins.markdown-preview.mappings")
        end,
        config = function()
            require("my.plugins.markdown-preview")
        end,
        ft = "markdown",
    },

    -- Autogenerate python docstrings
    {
        "heavenshell/vim-pydocstring",
        build = "make install",
        -- init = function()
        --     require("my.plugins.vim-pydocstring.mappings")
        -- end,
        config = function()
            require("my.plugins.vim-pydocstring")
        end,
        ft = "python",
        keys = {
            {
                "<leader>pl",
                "<Plug>(pydocstring)",
                {
                    remap = true,
                    desc = "Add docstring to function/class under cursor",
                },
            },
            {
                "<leader>pf",
                ":PydocstringFormat<CR>",
                { desc = "Add docstrings to all functions/classes in file" },
            },
            {
                "<leader>p",
                ":'<,'>Pydocstring<CR>",
                {
                    desc = "Add docstring to selected function/class",
                },
            },
        },
    },

    -- Fix python indentation
    { "Vimjas/vim-python-pep8-indent", ft = "python" },

    "christoomey/vim-sort-motion",
}

require("lazy").setup(plugins, {
    ui = {
        border = "rounded",
    },
})
