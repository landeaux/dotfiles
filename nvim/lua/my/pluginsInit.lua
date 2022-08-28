local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local packer_bootstrap = nil
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })
    vim.o.runtimepath = vim.fn.stdpath("data") .. "/site/pack/*/start/*," .. vim.o.runtimepath
end

local packer = require("packer")
local use = packer.use

packer.init({
    -- TODO: restore this once there is support for better diff view
    -- @see: https://github.com/wbthomason/packer.nvim/issues/459
    -- display = {
    --     open_fn = function()
    --         return require("packer.util").float({ border = "single" })
    --     end,
    --     prompt_border = "single",
    -- },
    git = {
        clone_timeout = 800, -- Timeout, in seconds, for git clones
    },
    compile_path = vim.fn.stdpath("config") .. "/lua/my/compiled.lua",
    auto_clean = true,
    compile_on_sync = true,
    -- profile = {
    --     enable = true,
    --     threshold = 1,
    -- },
})

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
            require("my.config.utility.whichkey")
        end,
    })

    -- Colorscheme
    use({ "folke/tokyonight.nvim" })
    use({ "mcchrish/zenbones.nvim", requires = "rktjmp/lush.nvim" })
    use({ "catppuccin/nvim", as = "catppuccin" })

    use({
        "rcarriga/nvim-notify",
        config = function()
            vim.notify = require("notify")
        end,
    })

    -- Neovim icons
    use({
        "kyazdani42/nvim-web-devicons",
        config = function()
            require("my.config.ui.nvim-web-devicons")
        end,
        -- disable = true,
    })

    use({
        "nvim-lualine/lualine.nvim",
        config = function()
            require("my.config.ui.lualine")
        end,
        requires = { "kyazdani42/nvim-web-devicons", opt = true },
    })

    -- Tab bar
    use({
        "akinsho/bufferline.nvim",
        tag = "v2.*",
        requires = "kyazdani42/nvim-web-devicons",
        config = function()
            require("my.config.ui.nvim-bufferline")
        end,
        after = "which-key.nvim",
    })

    -- Indent guides
    use({
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("my.config.ui.indent-blankline")
        end,
        -- disable = true,
        after = "which-key.nvim",
    })

    -- Colorize color codes
    use({
        "norcalli/nvim-colorizer.lua",
        config = function()
            require("my.config.utility.nvim-colorizer")
        end,
        -- disable = true,
        after = "which-key.nvim",
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
                    require("window-picker").setup({
                        autoselect_one = true,
                        include_current = false,
                        filter_rules = {
                            -- filter using buffer options
                            bo = {
                                -- if the file type is one of following, the window will be ignored
                                filetype = { "neo-tree", "neo-tree-popup", "notify", "quickfix" },

                                -- if the buffer type is one of following, the window will be ignored
                                buftype = { "terminal" },
                            },
                        },
                        other_win_hl_color = "#e35e4f",
                    })
                end,
            },
        },
        config = function()
            require("my.config.tools.neo-tree")
        end,
        cmd = {
            "Neotree",
        },
        keys = "<Leader>tn",
        after = { "which-key.nvim" },
    })

    -- Git
    use({
        "lewis6991/gitsigns.nvim",
        requires = { "nvim-lua/plenary.nvim" },
        config = function()
            require("my.config.ui.gitsigns")
        end,
        -- disable = true,
        after = "which-key.nvim",
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
        after = "which-key.nvim",
    })
    use({
        "junegunn/gv.vim",
        config = function()
            require("my.config.tools.gv")
        end,
        requires = { "tpope/vim-fugitive" },
        -- disable = true,
        after = "which-key.nvim",
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
        after = "which-key.nvim",
    })

    -- Floating Terminal
    use({
        "numtostr/FTerm.nvim",
        config = function()
            require("my.config.utility.fterm")
        end,
        keys = "<A-i>",
        after = "which-key.nvim",
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
        after = "which-key.nvim",
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
    use({
        "neovim/nvim-lspconfig",
        config = function()
            require("my.config.lsp")
        end,
        requires = {
            { "kosayoda/nvim-lightbulb" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "jose-elias-alvarez/typescript.nvim" },
            { "williamboman/mason.nvim" },
            { "williamboman/mason-lspconfig.nvim" },
            { "b0o/schemastore.nvim" }, -- for jsonls
            {
                "mrshmllow/document-color.nvim",
                config = function()
                    require("document-color").setup({
                        -- Default options
                        mode = "background", -- "background" | "foreground" | "single"
                    })
                end,
            },
        },
        after = "which-key.nvim",
    })

    use({
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
            require("my.config.lsp.providers.null_ls")
        end,
        requires = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    })

    -- Treesitter
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
        after = "which-key.nvim",
    })

    -- Debugging
    use({
        "mfussenegger/nvim-dap",
        config = function()
            require("my.config.dap")
        end,
        after = "which-key.nvim",
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
        after = { "nvim-dap", "which-key.nvim" },
        -- disable = true,
    })
    use({
        "mfussenegger/nvim-dap-python",
        requires = { "mfussenegger/nvim-dap" },
        config = function()
            require("my.config.dap.python")
        end,
        after = { "nvim-dap", "which-key.nvim" },
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
        after = { "nvim-dap", "which-key.nvim" },
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
        after = "which-key.nvim",
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
        after = "which-key.nvim",
    })

    -- Fix python indentation
    use({ "Vimjas/vim-python-pep8-indent", ft = "python" })

    -- Syntax highlighting for .mdx
    use({ "jxnblk/vim-mdx-js" })

    -- zk
    use({
        "mickael-menu/zk-nvim",
        config = function()
            require("zk").setup()
        end,
    })

    if packer_bootstrap then
        require("packer").sync()
    end
end)

local packer_sync = function()
    vim.notify("Syncing packer.", "info", { title = "Packer" })
    local snap_shot_time = os.date("!%Y-%m-%dT%TZ")
    vim.cmd("PackerSnapshot " .. snap_shot_time)
    vim.cmd("PackerSync")
end

vim.keymap.set("n", "<leader>ps", "", {
    callback = packer_sync,
})

require("my.utils").create_augroup({
    {
        event = "BufWritePost",
        opts = {
            pattern = "pluginsInit.lua",
            command = "source <afile> | PackerCompile",
        },
    },
}, "_packer")
