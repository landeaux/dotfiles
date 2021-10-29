local present, my_packer = pcall(require, "my.packer")

if not present then
    return false
end

local packer = my_packer.packer
local use = packer.use

return packer.startup(function()
    -- Packer
    use("wbthomason/packer.nvim")

    -- Colorscheme
    use({
        "folke/tokyonight.nvim",
        config = function()
            require("my.config.ui.tokyonight")
        end,
    })

    -- Neovim icons
    use({
        "kyazdani42/nvim-web-devicons",
        config = function()
            require("my.config.ui.nvim-web-devicons")
        end,
        after = "tokyonight.nvim",
    })

    -- Statusline
    use({
        "glepnir/galaxyline.nvim",
        requires = { "kyazdani42/nvim-web-devicons", opt = true },
        config = function()
            require("my.config.ui.galaxyline")
        end,
        after = "nvim-web-devicons",
    })

    -- TODO: specify all plugins which use whichkey to load after it
    -- Which Key
    use({ "AckslD/nvim-whichkey-setup.lua", requires = { "liuchengxu/vim-which-key" } })

    -- Tab bar
    use({
        "akinsho/nvim-bufferline.lua",
        config = function()
            require("my.config.ui.nvim-bufferline")
        end,
    })

    -- Start screen
    use({
        "glepnir/dashboard-nvim",
        config = function()
            require("my.config.ui.dashboard-nvim")
        end,
        -- TODO: specify this to run after Telescope
    })

    -- Indent guides
    use({
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("my.config.ui.indent-blankline")
        end,
    })

    -- Colorize color codes
    -- TODO: figure out how to make this enabled on start up
    use({
        "norcalli/nvim-colorizer.lua",
        config = function()
            require("my.config.utility.nvim-colorizer")
        end,
    })

    -- File Tree
    use({
        "kyazdani42/nvim-tree.lua",
        config = function()
            require("my.config.tools.nvim-tree")
        end,
        after = "nvim-web-devicons",
    })

    -- Git
    use({
        "lewis6991/gitsigns.nvim",
        requires = { "nvim-lua/plenary.nvim" },
        event = "BufRead",
        config = function()
            require("my.config.ui.gitsigns")
        end,
    })
    use({
        "tpope/vim-fugitive",
        config = function()
            require("my.config.tools.fugitive")
        end,
    })
    use({
        "junegunn/gv.vim",
        config = function()
            require("my.config.tools.gv")
        end,
        requires = { "tpope/vim-fugitive" },
    })

    -- Undo Tree
    use("mbbill/undotree")

    -- Register Preview
    use("gennaro-tedesco/nvim-peekup")

    -- Floating Terminal
    use("numtostr/FTerm.nvim")

    -- Color Picker
    use("KabbAmine/vCoolor.vim")

    -- Surround
    use("tpope/vim-surround")

    -- Comments
    use("b3nj5m1n/kommentary")
    use("JoosepAlviste/nvim-ts-context-commentstring")

    -- Automatic pair insertion
    use("windwp/nvim-autopairs")

    -- Remember last location in file
    use("farmergreg/vim-lastplace")

    -- UNIX helper
    use("tpope/vim-eunuch")

    -- Automatically change current directory
    use("airblade/vim-rooter")

    -- Editorconfig
    use("editorconfig/editorconfig-vim")

    -- LSP
    use("neovim/nvim-lspconfig")
    use("kabouzeid/nvim-lspinstall")
    use("glepnir/lspsaga.nvim")
    -- use 'ray-x/lsp_signature.nvim'
    use("kosayoda/nvim-lightbulb")

    -- TypeScript
    use({ "jose-elias-alvarez/nvim-lsp-ts-utils", requires = { "nvim-lua/plenary.nvim" } })

    -- Telescope
    -- use({
    --     "nvim-telescope/telescope.nvim",
    --     requires = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } },
    -- })

    -- Search and replace across multiple files
    use("brooth/far.vim")

    -- Completion
    use("hrsh7th/nvim-cmp")

    ---- Completion Sources
    use("f3fora/cmp-spell")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/cmp-calc")
    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/cmp-nvim-lua")
    use("hrsh7th/cmp-path")
    use("hrsh7th/cmp-vsnip")

    -- Snippets
    use("rafamadriz/friendly-snippets")
    use("L3MON4D3/LuaSnip")
    use("saadparwaiz1/cmp_luasnip")

    -- Tresitter
    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
    use("nvim-treesitter/nvim-treesitter-textobjects")

    -- Debugging
    -- use("mfussenegger/nvim-dap")
    -- use("mfussenegger/nvim-dap-python")
    -- use("theHamsta/nvim-dap-virtual-text")
    -- use("nvim-telescope/telescope-dap.nvim")
    -- use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } })

    -- Markdown preview
    use({
        "iamcco/markdown-preview.nvim",
        run = function()
            vim.fn["mkdp#util#install"]()
        end,
    })

    -- Meta
    -- Read line and column from the command line
    use("wsdjeg/vim-fetch")

    -- Profiler
    use({ "norcalli/profiler.nvim", opt = true })

    -- Startuptime
    use("tweekmonster/startuptime.vim")

    use({
        "famiu/nvim-reload",
        requires = { "nvim-lua/plenary.nvim" },
    })

    -- Autogenerate python docstrings
    use({ "heavenshell/vim-pydocstring", run = "make install" })

    -- Fix python indentation
    use("Vimjas/vim-python-pep8-indent")

    if my_packer.first_install then
        packer.sync()
    end
end)
