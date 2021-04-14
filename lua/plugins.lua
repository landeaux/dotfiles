-- check if packer is installed (~/local/share/nvim/site/pack)
local packer_exists = pcall(vim.cmd, [[packadd packer.nvim]])

return require('packer').startup(function()

    -- Packer can manage itself as an optional plugin
    use { 'wbthomason/packer.nvim', opt = true }

    -- Color scheme
    -- use { 'morhetz/gruvbox' }
    use { 'dracula/vim' }

    -- Fuzzy finder
    use {
        'nvim-telescope/telescope.nvim',
        requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
    }

    -- LSP and completion
    use { 'neovim/nvim-lspconfig' } -- LSP
    use { 'hrsh7th/nvim-compe' } -- Completion
    -- use { 'nvim-lua/completion-nvim' } -- completion
    use { 'onsails/lspkind-nvim' } -- add pictograms to LSP completion items
    -- use { 'kabouzeid/nvim-lspinstall' } -- install LSPs using :LspInstall <language>
    -- use { 'neoclide/coc.nvim', branch = 'release' } -- CoC 
    -- use { 'ray-x/lsp_signature.nvim' }
    use { 'kosayoda/nvim-lightbulb' }

    -- Snippets
    use { 'hrsh7th/vim-vsnip' }
    use { 'hrsh7th/vim-vsnip-integ'}


    -- Lua development
    -- use { 'tjdevries/nlua.nvim' }

    -- Fugitive for Git
    use { 'tpope/vim-fugitive' }

    -- Indent lines
    use { 'lukas-reineke/indent-blankline.nvim', branch = 'lua' }

    -- Git signs
    use { 'lewis6991/gitsigns.nvim' }

    -- Treesitter
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

    -- Colorizer
    use { 'norcalli/nvim-colorizer.lua' }

    -- Autopairs
    -- use { 'windwp/nvim-autopairs' }

    -- Delimit
    use { 'Raimondi/delimitMate' }

    -- Auto-close HTML tags
    use { 'alvan/vim-closetag' }

    -- Neoformat
    -- use { 'sbdchd/neoformat' }

    -- Icons
    use { 'kyazdani42/nvim-web-devicons' }

    -- Status line
    use { 'glepnir/galaxyline.nvim' }

    -- File tree
    use { 'kyazdani42/nvim-tree.lua' }

    -- Startuptime
    use { 'tweekmonster/startuptime.vim' }

    -- Better Python indentation
    use { 'Vimjas/vim-python-pep8-indent' }

    -- Commenting
    use { 'terrortylor/nvim-comment' }
    use { 'JoosepAlviste/nvim-ts-context-commentstring' }

end)

