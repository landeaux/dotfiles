local my_packer = require("my.packer")
local packer = my_packer.packer
local use = packer.use

packer.startup(function()
    -- Packer
    use({
        "wbthomason/packer.nvim",
        "lewis6991/impatient.nvim",
        "nvim-lua/plenary.nvim",
    })

    -- Which Key
    use({
        "folke/which-key.nvim",
        config = function()
            require("my.plugins.whichkey")
        end,
    })

    -- Colorscheme
    use({
        "folke/tokyonight.nvim",
        config = function()
            require("my.plugins.tokyonight")
        end,
        disable = vim.g.theme ~= "tokyonight",
    })
    use({
        "mcchrish/zenbones.nvim",
        requires = "rktjmp/lush.nvim",
        config = function()
            require("my.plugins.zenbones")
        end,
        disable = vim.g.theme ~= "zenbones",
    })
    use({
        "catppuccin/nvim",
        as = "catppuccin",
        config = function()
            require("my.plugins.catppuccin")
        end,
        disable = vim.g.theme ~= "catppuccin",
    })

    use({
        "rcarriga/nvim-notify",
        config = function()
            require("my.plugins.nvim-notify")
        end,
    })

    -- Neovim icons
    use({
        "kyazdani42/nvim-web-devicons",
        config = function()
            require("my.plugins.nvim-web-devicons")
        end,
    })

    use({
        "nvim-lualine/lualine.nvim",
        config = function()
            require("my.plugins.lualine")
        end,
        requires = { "kyazdani42/nvim-web-devicons", opt = true },
    })

    -- Tab bar
    use({
        "akinsho/bufferline.nvim",
        tag = "v2.*",
        requires = "kyazdani42/nvim-web-devicons",
        setup = function()
            require("my.plugins.bufferline.mappings")
        end,
        config = function()
            require("my.plugins.bufferline")
        end,
    })

    -- Indent guides
    use({
        "lukas-reineke/indent-blankline.nvim",
        setup = function()
            require("my.plugins.indent-blankline.mappings")
        end,
        config = function()
            require("my.plugins.indent-blankline")
        end,
    })

    -- Colorize color codes
    use({
        "norcalli/nvim-colorizer.lua",
        setup = function()
            require("my.plugins.nvim-colorizer.mappings")
        end,
        config = function()
            require("my.plugins.nvim-colorizer")
        end,
    })

    -- File Tree
    use({
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        requires = {
            "nvim-lua/plenary.nvim",
            "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
            {
                -- only needed if you want to use the commands with "_with_window_picker" suffix
                "s1n7ax/nvim-window-picker",
                tag = "v1.*",
                config = function()
                    require("my.plugins.window-picker")
                end,
            },
        },
        setup = function()
            require("my.plugins.neo-tree.mappings")
        end,
        config = function()
            require("my.plugins.neo-tree")
        end,
        cmd = {
            "Neotree",
        },
    })

    -- Git
    use({
        "lewis6991/gitsigns.nvim",
        requires = { "nvim-lua/plenary.nvim" },
        config = function()
            require("my.plugins.gitsigns")
        end,
        after = "which-key.nvim",
    })
    use({
        "tpope/vim-fugitive",
        setup = function()
            require("my.plugins.fugitive.mappings")
        end,
        cmd = {
            "G",
            "GBrowse",
            "GDelete",
            "GMove",
            "GRename",
            "Gdiffsplit",
            "Git",
        },
        keys = "<Leader>g",
    })
    use({
        "junegunn/gv.vim",
        requires = { "tpope/vim-fugitive" },
        setup = function()
            require("my.plugins.gv.mappings")
        end,
    })

    -- Undo Tree
    use({
        "mbbill/undotree",
        setup = function()
            require("my.plugins.undotree.mappings")
        end,
        cmd = "UndotreeToggle",
    })

    -- Floating Terminal
    use({
        "numtostr/FTerm.nvim",
        setup = function()
            require("my.plugins.fterm.mappings")
        end,
        config = function()
            require("my.plugins.fterm")
        end,
    })

    -- Surround
    use("tpope/vim-surround")

    -- Comments
    use({
        "b3nj5m1n/kommentary",
        setup = function()
            require("my.plugins.kommentary.mappings")
        end,
        config = function()
            require("my.plugins.kommentary")
        end,
        requires = { "JoosepAlviste/nvim-ts-context-commentstring" },
    })

    -- Remember last location in file
    use("farmergreg/vim-lastplace")

    -- UNIX helper
    use("tpope/vim-eunuch")

    -- Automatically change current directory
    use({
        "airblade/vim-rooter",
        config = function()
            require("my.plugins.rooter")
        end,
    })

    -- Editorconfig
    use("editorconfig/editorconfig-vim")

    -- Tooling Installer (LSP servers, formatters, linters, debuggers)
    use({
        "williamboman/mason.nvim",
        config = function()
            require("my.plugins.mason")
        end,
    })

    -- LSP
    use({
        "neovim/nvim-lspconfig",
        config = function()
            require("my.plugins.lsp")
        end,
        requires = {
            { "kosayoda/nvim-lightbulb" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "jose-elias-alvarez/typescript.nvim" },
            { "williamboman/mason-lspconfig.nvim" },
            { "b0o/schemastore.nvim" }, -- for jsonls
            {
                "mrshmllow/document-color.nvim",
                config = function()
                    require("my.plugins.document-color")
                end,
            },
        },
        after = "which-key.nvim",
    })

    use({
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
            require("my.plugins.lsp.providers.null_ls")
        end,
        requires = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    })

    -- Treesitter
    use({
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        setup = function()
            require("my.plugins.tree-sitter.mappings")
        end,
        config = function()
            require("my.plugins.tree-sitter")
        end,
    })
    use({ "windwp/nvim-ts-autotag", after = "nvim-treesitter" })
    use({ "JoosepAlviste/nvim-ts-context-commentstring", after = "nvim-treesitter" })
    use({ "nvim-treesitter/nvim-treesitter-textobjects", after = "nvim-treesitter" })

    -- Debugging
    use({
        "mfussenegger/nvim-dap",
        setup = function()
            require("my.plugins.nvim-dap.mappings")
        end,
        config = function()
            require("my.plugins.nvim-dap")
        end,
    })
    use({
        "theHamsta/nvim-dap-virtual-text",
        config = function()
            require("my.plugins.nvim-dap-virtual-text")
        end,
        requires = {
            "mfussenegger/nvim-dap",
            "nvim-treesitter/nvim-treesitter",
        },
        after = "nvim-dap",
    })
    use({
        "mfussenegger/nvim-dap-python",
        requires = { "mfussenegger/nvim-dap" },
        setup = function()
            require("my.plugins.nvim-dap-python.mappings")
        end,
        config = function()
            require("my.plugins.nvim-dap-python")
        end,
        after = "nvim-dap",
    })

    -- Telescope
    use({
        "nvim-telescope/telescope.nvim",
        requires = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                run = "make",
            },
            "nvim-telescope/telescope-dap.nvim",
        },
        setup = function()
            require("my.plugins.telescope-nvim.mappings")
        end,
        config = function()
            require("my.plugins.telescope-nvim")
        end,
    })

    -- Automatic pair insertion
    use({
        "windwp/nvim-autopairs",
        config = function()
            require("my.plugins.nvim-autopairs")
        end,
    })

    -- Completion
    use({
        "L3MON4D3/LuaSnip",
        config = function()
            require("my.plugins.lsp.luasnip")
        end,
        requires = "rafamadriz/friendly-snippets",
    })
    use({
        "hrsh7th/nvim-cmp",
        config = function()
            require("my.plugins.lsp.nvim-cmp")
        end,
        requires = {
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-calc",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-path",
            "saadparwaiz1/cmp_luasnip",
            "L3MON4D3/LuaSnip",
            "windwp/nvim-autopairs",
        },
        -- event = "InsertEnter *",
        after = "LuaSnip",
    })

    -- Markdown preview
    use({
        "iamcco/markdown-preview.nvim",
        run = function()
            vim.fn["mkdp#util#install"]()
        end,
        setup = function()
            require("my.plugins.markdown-preview.mappings")
        end,
        config = function()
            require("my.plugins.markdown-preview")
        end,
        ft = "markdown",
    })

    -- Startuptime
    use({ "tweekmonster/startuptime.vim", cmd = "StartupTime" })

    -- Autogenerate python docstrings
    use({
        "heavenshell/vim-pydocstring",
        run = "make install",
        setup = function()
            require("my.plugins.vim-pydocstring.mappings")
        end,
        config = function()
            require("my.plugins.vim-pydocstring")
        end,
        ft = "python",
    })

    -- Fix python indentation
    use({ "Vimjas/vim-python-pep8-indent", ft = "python" })

    -- Syntax highlighting for .mdx
    use({ "jxnblk/vim-mdx-js", ft = "mdx" })

    -- zk
    use({
        "mickael-menu/zk-nvim",
        config = function()
            require("my.plugins.zk-nvim")
        end,
        ft = "markdown",
    })

    if my_packer.packer_bootstrap then
        packer.sync()
    end
end)
