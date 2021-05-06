-- Plugins
local packer = require('packer')
local use = packer.use

packer.reset()
packer.init()

-- Packer
use 'wbthomason/packer.nvim'

-- Colorscheme
-- use 'dracula/vim'
use 'christianchiarulli/nvcode-color-schemes.vim'

-- Statusline
use 'glepnir/galaxyline.nvim'

-- Tab bar
use 'akinsho/nvim-bufferline.lua'

-- Start screen
use 'glepnir/dashboard-nvim'

-- Colorize color codes
use 'chrisbra/Colorizer'

-- Neovim icons
use 'kyazdani42/nvim-web-devicons'

-- Indent guides
use {'lukas-reineke/indent-blankline.nvim', branch = 'lua'}

-- Which Key
use {
    'AckslD/nvim-whichkey-setup.lua',
    requires = {'liuchengxu/vim-which-key'},
}

-- File Tree
use 'kyazdani42/nvim-tree.lua'

-- Git
use 'tpope/vim-fugitive'
use {'lewis6991/gitsigns.nvim', requires = {'nvim-lua/plenary.nvim'}}
use 'junegunn/gv.vim'

-- Undo Tree
use 'mbbill/undotree'

-- Register Preview
use 'gennaro-tedesco/nvim-peekup'

-- Floating Terminal
use "numtostr/FTerm.nvim"

-- Color Picker
use 'KabbAmine/vCoolor.vim'

-- Surround
use 'tpope/vim-surround'

-- Comments
use 'b3nj5m1n/kommentary'
use 'JoosepAlviste/nvim-ts-context-commentstring'

-- Tabs and text alignment
use 'godlygeek/tabular'

-- Delimit
use 'Raimondi/delimitMate'

-- Remember last location in file
use 'farmergreg/vim-lastplace'

-- UNIX helper
use 'tpope/vim-eunuch'

-- Automatically change current directory
use 'airblade/vim-rooter'

-- Editorconfig
use 'editorconfig/editorconfig-vim'

-- Snippets
use 'hrsh7th/vim-vsnip'
use 'hrsh7th/vim-vsnip-integ'
use 'rafamadriz/friendly-snippets'

-- LSP
use 'neovim/nvim-lspconfig'
use 'kabouzeid/nvim-lspinstall'
-- use 'onsails/lspkind-nvim'
use 'glepnir/lspsaga.nvim'
use 'ray-x/lsp_signature.nvim'
use 'kosayoda/nvim-lightbulb'

-- Telescope
use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
}

-- Search and replace across multiple files
use 'brooth/far.vim'

-- Completion
use 'hrsh7th/nvim-compe'

-- Tresitter
use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
use 'nvim-treesitter/nvim-treesitter-textobjects'

-- Debugging
use 'mfussenegger/nvim-dap'
use 'mfussenegger/nvim-dap-python'
use 'theHamsta/nvim-dap-virtual-text'
use 'nvim-telescope/telescope-dap.nvim'

-- Markdown preview
use {
    'iamcco/markdown-preview.nvim',
    run = function() vim.fn['mkdp#util#install']() end
}

-- Meta
-- Read line and column from the command line
use 'wsdjeg/vim-fetch'

-- Profiler
use { 'norcalli/profiler.nvim', opt = true }

-- Startuptime
use 'tweekmonster/startuptime.vim'

-- Autogenerate python docstrings
use { 'heavenshell/vim-pydocstring', run = 'make install' }

-- Fix python indentation
use 'Vimjas/vim-python-pep8-indent'
