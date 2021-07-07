-- Do not use plugins when running as root or neovim < 0.5
if require("utils").is_root() or not require("utils").has_neovim_v05() then
    return {
        sync_if_not_compiled = function()
            return
        end,
    }
end

local execute = vim.api.nvim_command

-- check if packer is installed (~/.local/share/nvim/site/pack)
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local compile_path = install_path .. "/plugin/packer_compiled.vim"
local is_installed = vim.fn.empty(vim.fn.glob(install_path)) == 0
local is_compiled = vim.fn.empty(vim.fn.glob(compile_path)) == 0

if not is_installed then
    if vim.fn.input("Install packer.nvim? (y for yes) ") == "y" then
        execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
        execute("packadd packer.nvim")
        print("Installed packer.nvim.")
        is_installed = 1
    end
end

-- Packer commands
vim.cmd([[command! PackerInstall packadd packer.nvim | lua require('plugins').install()]])
vim.cmd([[command! PackerUpdate packadd packer.nvim | lua require('plugins').update()]])
vim.cmd([[command! PackerSync packadd packer.nvim | lua require('plugins').sync()]])
vim.cmd([[command! PackerClean packadd packer.nvim | lua require('plugins').clean()]])
vim.cmd([[command! PackerCompile packadd packer.nvim | lua require('plugins').compile()]])
vim.cmd([[command! PC PackerCompile]])
vim.cmd([[command! PS PackerStatus]])
vim.cmd([[command! PU PackerSync]])

local packer = nil

local function init()
    if not is_installed then
        return
    end
    if packer == nil then
        packer = require("packer")
        packer.init({
            -- we don't want the compilation file in '~/.config/nvim'
            compile_path = compile_path,
        })
    end

    local use = packer.use

    -- Packer
    use("wbthomason/packer.nvim")

    -- Colorscheme
    -- use 'dracula/vim'
    -- use("christianchiarulli/nvcode-color-schemes.vim")
    use("folke/tokyonight.nvim")

    -- Statusline
    use("glepnir/galaxyline.nvim")

    -- Tab bar
    use("akinsho/nvim-bufferline.lua")

    -- Start screen
    use("glepnir/dashboard-nvim")

    -- Colorize color codes
    use("chrisbra/Colorizer")

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

    -- Delimit
    use("Raimondi/delimitMate")

    -- Remember last location in file
    use("farmergreg/vim-lastplace")

    -- UNIX helper
    use("tpope/vim-eunuch")

    -- Automatically change current directory
    use("airblade/vim-rooter")

    -- Editorconfig
    use("editorconfig/editorconfig-vim")

    -- Snippets
    use("hrsh7th/vim-vsnip")
    use("hrsh7th/vim-vsnip-integ")
    use("rafamadriz/friendly-snippets")

    -- LSP
    use("neovim/nvim-lspconfig")
    use("kabouzeid/nvim-lspinstall")
    -- use 'onsails/lspkind-nvim'
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
    use("hrsh7th/nvim-compe")

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
end

-- called from 'lua/autocmd.lua' at `VimEnter`
local function sync_if_not_compiled()
    if packer == nil then
        return
    end
    if not is_compiled then
        packer.sync()
        --execute("luafile $MYVIMRC")
    end
end

local plugins = setmetatable({}, {
    __index = function(_, key)
        init()
        -- workaround for error when packer not installed
        if packer == nil then
            return function() end
        end
        if key == "sync_if_not_compiled" then
            return sync_if_not_compiled
        else
            return packer[key]
        end
    end,
})

return plugins
