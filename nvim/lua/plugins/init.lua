local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local packer_bootstrap

if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })
end

return require("packer").startup(function(use)
    -- Packer
    use("wbthomason/packer.nvim")

    -- Colorscheme
    -- use 'dracula/vim'
    -- use("christianchiarulli/nvcode-color-schemes.vim")
    use({
        "folke/tokyonight.nvim",
        config = function()
            require("plugins.config.ui.tokyonight")
        end,
    })

    -- Statusline
    use("glepnir/galaxyline.nvim")

    -- Tab bar
    use("akinsho/nvim-bufferline.lua")

    -- Start screen
    use("glepnir/dashboard-nvim")

    -- Colorize color codes
    use("norcalli/nvim-colorizer.lua")

    -- Neovim icons
    use("kyazdani42/nvim-web-devicons")

    -- Indent guides
    use("lukas-reineke/indent-blankline.nvim")

    -- Which Key
    use({ "AckslD/nvim-whichkey-setup.lua", requires = { "liuchengxu/vim-which-key" } })

    -- File Tree
    use("kyazdani42/nvim-tree.lua")

    -- Git
    use("tpope/vim-fugitive")
    use({ "lewis6991/gitsigns.nvim", requires = { "nvim-lua/plenary.nvim" } })
    use("junegunn/gv.vim")

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
    use({
        "nvim-telescope/telescope.nvim",
        requires = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } },
    })

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
    -- use("hrsh7th/vim-vsnip")
    -- use("hrsh7th/vim-vsnip-integ")
    use("rafamadriz/friendly-snippets")
    use("L3MON4D3/LuaSnip")
    use("saadparwaiz1/cmp_luasnip")

    -- Tresitter
    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
    use("nvim-treesitter/nvim-treesitter-textobjects")

    -- Debugging
    use("mfussenegger/nvim-dap")
    use("mfussenegger/nvim-dap-python")
    use("theHamsta/nvim-dap-virtual-text")
    use("nvim-telescope/telescope-dap.nvim")
    use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } })

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

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require("packer").sync()
    end
end)
