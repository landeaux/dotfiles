-- Build hooks: registered before vim.pack.add() so they fire on first install
vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
        local name, kind = ev.data.spec.name, ev.data.kind
        if kind ~= "install" and kind ~= "update" then
            return
        end

        if name == "nvim-treesitter" then
            if not ev.data.active then
                vim.cmd.packadd("nvim-treesitter")
            end
            vim.cmd("TSUpdate")
        elseif name == "LuaSnip" then
            vim.fn.system({ "make", "install_jsregexp" })
        elseif name == "vim-pydocstring" then
            vim.fn.system({ "make", "install" })
        elseif name == "markdown-preview.nvim" then
            vim.fn["mkdp#util#install"]()
        elseif name == "vscode-js-debug" then
            vim.fn.system({ "npm", "install", "--legacy-peer-deps" })
            vim.fn.system({ "npm", "run", "compile" })
        end
    end,
})

vim.pack.add({
    -- Colorscheme first so it's applied before other UI plugins initialize
    "https://github.com/rebelot/kanagawa.nvim",

    -- Core dependencies
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/MunifTanjim/nui.nvim",
    "https://github.com/nvim-neotest/nvim-nio",
    "https://github.com/nvim-tree/nvim-web-devicons",
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects", version = "main" },
    "https://github.com/windwp/nvim-ts-autotag",

    -- Editor
    "https://github.com/tpope/vim-surround",
    "https://github.com/tpope/vim-dispatch",
    "https://github.com/tpope/vim-eunuch",
    "https://github.com/tpope/vim-fugitive",
    "https://github.com/christoomey/vim-sort-motion",
    "https://github.com/farmergreg/vim-lastplace",
    "https://github.com/numToStr/FTerm.nvim",
    "https://github.com/stevearc/oil.nvim",
    "https://github.com/ibhagwan/fzf-lua",
    "https://github.com/lukas-reineke/indent-blankline.nvim",
    "https://github.com/lewis6991/gitsigns.nvim",
    "https://github.com/stevearc/dressing.nvim",
    "https://github.com/b0o/schemastore.nvim",
    "https://github.com/sindrets/diffview.nvim",
    "https://github.com/fladson/vim-kitty",
    "https://github.com/notjedi/nvim-rooter.lua",
    "https://github.com/tartansandal/vim-compiler-pytest",

    -- Completion / snippets
    "https://github.com/rafamadriz/friendly-snippets",
    { src = "https://github.com/L3MON4D3/LuaSnip", version = vim.version.range("2.x") },
    "https://github.com/hrsh7th/cmp-calc",
    "https://github.com/saghen/blink.compat",
    { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.x") },

    -- LSP / formatting / linting
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/mason-org/mason.nvim",
    "https://github.com/yioneko/nvim-vtsls",
    "https://github.com/stevearc/conform.nvim",
    "https://github.com/nvimtools/none-ls.nvim",
    "https://github.com/nvimtools/none-ls-extras.nvim",
    "https://github.com/folke/lazydev.nvim",

    -- DAP
    "https://github.com/mfussenegger/nvim-dap",
    "https://github.com/rcarriga/nvim-dap-ui",
    "https://github.com/theHamsta/nvim-dap-virtual-text",
    "https://github.com/mxsdev/nvim-dap-vscode-js",
    { src = "https://github.com/microsoft/vscode-js-debug", version = "v1.76.1" },

    -- UI / visual
    "https://github.com/nvim-lualine/lualine.nvim",
    "https://github.com/luukvbaal/statuscol.nvim",
    "https://github.com/kosayoda/nvim-lightbulb",
    "https://github.com/catgoose/nvim-colorizer.lua",

    -- Misc / language
    { src = "https://github.com/epwalsh/obsidian.nvim", version = vim.version.range("*") },
    "https://github.com/iamcco/markdown-preview.nvim",
    "https://github.com/esmuellert/codediff.nvim",
    { src = "https://github.com/mikesmithgh/kitty-scrollback.nvim", version = vim.version.range("6.x") },
    "https://github.com/numToStr/Comment.nvim",
    "https://github.com/JoosepAlviste/nvim-ts-context-commentstring",
    "https://github.com/heavenshell/vim-pydocstring",
    "https://github.com/Vimjas/vim-python-pep8-indent",
})

-- Setup in dependency order. Simple plugins (vim-surround, vim-lastplace, etc.)
-- need no setup call — vim.pack loads them onto rtp and they work automatically.

require("my.plugins.kanagawa")

require("my.plugins.nvim-web-devicons")
require("my.plugins.nvim-treesitter")
require("my.plugins.nvim-ts-autotag")

require("my.plugins.vim-fugitive")
require("my.plugins.fterm")
require("my.plugins.oil-nvim")
require("my.plugins.fzf-lua")
require("my.plugins.indent-blankline")
require("my.plugins.gitsigns")
require("my.plugins.dressing-nvim")
require("my.plugins.diffview")
require("my.plugins.nvim-rooter")
require("my.plugins.nvim-colorizer")

require("my.plugins.luasnip")
require("my.plugins.blink-cmp")

require("my.plugins.lazydev-nvim")
require("my.plugins.lsp")
require("my.plugins.mason")
require("my.plugins.conform-nvim")
require("my.plugins.none-ls")

require("my.plugins.dap")

require("my.plugins.lualine")
require("my.plugins.statuscol-nvim")
require("my.plugins.nvim-lightbulb")

require("my.plugins.obsidian-nvim")
require("my.plugins.markdown-preview")
require("my.plugins.codediff")
require("my.plugins.kitty-scrollback-nvim")
require("my.plugins.comment-nvim")
require("my.plugins.vim-pydocstring")
