local present, my_packer = pcall(require, "my.packer")

if not present then
    return false
end

local packer = my_packer.packer
local use = packer.use

return packer.startup(function()
    -- Packer
    use({
        "wbthomason/packer.nvim",
        "lewis6991/impatient.nvim",
        "nvim-lua/plenary.nvim",
    })

    -- Colorscheme
    use({
        "folke/tokyonight.nvim",
        config = function()
            require("my.config.ui.tokyonight")
        end,
        -- disable = true,
    })

    -- Neovim icons
    use({
        "kyazdani42/nvim-web-devicons",
        config = function()
            require("my.config.ui.nvim-web-devicons")
        end,
        after = "tokyonight.nvim",
        -- disable = true,
    })

    -- Statusline
    use({
        "glepnir/galaxyline.nvim",
        requires = { "kyazdani42/nvim-web-devicons", opt = true },
        config = function()
            require("my.config.ui.galaxyline")
        end,
        after = "nvim-web-devicons",
        -- disable = true,
    })

    -- Which Key
    use({
        "AckslD/nvim-whichkey-setup.lua",
        requires = { "liuchengxu/vim-which-key" },
        config = function()
            require("my.config.utility.whichkey")
        end,
    })

    -- Tab bar
    use({
        "akinsho/nvim-bufferline.lua",
        config = function()
            require("my.config.ui.nvim-bufferline")
        end,
        -- disable = true,
    })

    -- Indent guides
    use({
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("my.config.ui.indent-blankline")
        end,
        -- disable = true,
    })

    -- Colorize color codes
    -- TODO: figure out how to make this enabled on start up
    use({
        "norcalli/nvim-colorizer.lua",
        config = function()
            require("my.config.utility.nvim-colorizer")
        end,
        -- disable = true,
    })

    -- File Tree
    use({
        "kyazdani42/nvim-tree.lua",
        config = function()
            require("my.config.tools.nvim-tree")
        end,
        cmd = {
            "NvimTreeClipboard",
            "NvimTreeClose",
            "NvimTreeFindFile",
            "NvimTreeOpen",
            "NvimTreeRefresh",
            "NvimTreeToggle",
        },
        keys = "<Leader>tn",
        after = "nvim-web-devicons",
        -- disable = true,
    })

    -- Git
    use({
        "lewis6991/gitsigns.nvim",
        requires = { "nvim-lua/plenary.nvim" },
        config = function()
            require("my.config.ui.gitsigns")
        end,
        -- disable = true,
    })
    use({
        "tpope/vim-fugitive",
        config = function()
            require("my.config.tools.fugitive")
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
        -- disable = true,
    })
    use({
        "junegunn/gv.vim",
        config = function()
            require("my.config.tools.gv")
        end,
        requires = { "tpope/vim-fugitive" },
        -- disable = true,
    })

    -- Undo Tree
    use({
        "mbbill/undotree",
        config = function()
            require("my.config.tools.undotree")
        end,
        keys = "<Leader>tu",
        cmd = "UndotreeToggle",
        -- disable = true,
    })

    -- Floating Terminal
    use({
        "numtostr/FTerm.nvim",
        config = function()
            require("my.config.utility.fterm")
        end,
        keys = "<A-i>",
    })

    -- Surround
    use("tpope/vim-surround")

    -- Comments
    use({
        "b3nj5m1n/kommentary",
        config = function()
            require("my.config.utility.kommentary")
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
            require("my.config.utility.rooter")
        end,
    })

    -- Editorconfig
    use("editorconfig/editorconfig-vim")

    -- LSP
    use({ -- lsp
        "neovim/nvim-lspconfig",
        config = function()
            require("my.config.lsp")
        end,
        requires = {
            {
                "ray-x/lsp_signature.nvim",
                config = function()
                    -- must happen after servers are set up
                    require("lsp_signature").setup({
                        bind = true, -- This is mandatory, otherwise border config won't get registered.
                        handler_opts = {
                            border = "rounded",
                        },
                    })
                end,
                after = "nvim-lspconfig",
            },
            { "kosayoda/nvim-lightbulb" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "jose-elias-alvarez/nvim-lsp-ts-utils" },
            { "williamboman/nvim-lsp-installer" },
        },
    })

    use({
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
            require("my.config.lsp.providers.null_ls")
        end,
        requires = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    })

    -- Tresitter
    use({
        "nvim-treesitter/nvim-treesitter",
        requires = {
            "windwp/nvim-ts-autotag",
            "JoosepAlviste/nvim-ts-context-commentstring",
            "nvim-treesitter/nvim-treesitter-textobjects",
        },
        run = ":TSUpdate",
        config = function()
            require("my.config.utility.tree-sitter")
        end,
        -- disable = true,
    })

    -- Debugging
    use({
        "mfussenegger/nvim-dap",
        config = function()
            require("my.config.dap")
        end,
        after = "tokyonight.nvim",
        -- disable = true,
    })
    use({
        "theHamsta/nvim-dap-virtual-text",
        config = function()
            vim.g.dap_virtual_text = true
        end,
        requires = {
            "mfussenegger/nvim-dap",
            "nvim-treesitter/nvim-treesitter",
        },
        after = "nvim-dap",
        -- disable = true,
    })
    use({
        "rcarriga/nvim-dap-ui",
        requires = { "mfussenegger/nvim-dap" },
        config = function()
            require("my.config.dap.ui")
        end,
        after = "nvim-dap",
        -- disable = true,
    })
    use({
        "mfussenegger/nvim-dap-python",
        requires = { "mfussenegger/nvim-dap" },
        config = function()
            require("my.config.dap.python")
        end,
        after = "nvim-dap",
        -- disable = true,
    })

    -- Telescope
    use({
        "nvim-telescope/telescope.nvim",
        requires = {
            "nvim-lua/popup.nvim",
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                run = "make",
            },
            "nvim-telescope/telescope-dap.nvim",
        },
        config = function()
            require("my.config.tools.telescope-nvim")
        end,
        cmd = "Telescope",
        keys = { "<Leader>f", "<S-A-p>" },
        module = "telescope",
        after = "nvim-dap",
    })

    -- Search and replace across multiple files
    use({
        "brooth/far.vim",
        cmd = {
            "Far",
            "Fardo",
            "Farf",
            "Farp",
            "Farr",
            "Farundo",
        },
    })

    -- Automatic pair insertion
    use({
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup({})
        end,
    })

    -- Completion
    use({
        "hrsh7th/nvim-cmp",
        config = function()
            require("my.config.lsp.nvim-cmp")
        end,
        requires = {
            "f3fora/cmp-spell",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-calc",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-path",
            "saadparwaiz1/cmp_luasnip",
            {
                "L3MON4D3/LuaSnip",
                config = function()
                    require("my.config.lsp.luasnip")
                end,
                requires = "rafamadriz/friendly-snippets",
            },
            "windwp/nvim-autopairs",
        },
        -- event = "InsertEnter *",
    })

    -- Markdown preview
    use({
        "iamcco/markdown-preview.nvim",
        run = function()
            vim.fn["mkdp#util#install"]()
        end,
        config = function()
            require("my.config.utility.markdown-preview")
        end,
        ft = "markdown",
    })

    -- Startuptime
    use({ "tweekmonster/startuptime.vim", cmd = "StartupTime" })

    -- Autogenerate python docstrings
    use({
        "heavenshell/vim-pydocstring",
        run = "make install",
        config = function()
            require("my.config.utility.vim-pydocstring")
        end,
    })

    -- Fix python indentation
    use({ "Vimjas/vim-python-pep8-indent", ft = "python" })

    if my_packer.first_install then
        packer.sync()
    end
end)
