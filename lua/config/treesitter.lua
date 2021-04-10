local ts_config = require('nvim-treesitter.configs')

ts_config.setup {
    ensure_installed = {
        'bash',
        'css',
        'html',
        'javascript',
        'lua',
        'python',
        'vue',
    },
    highlight = {
        enable = true,
        use_languagetree = true
    },
    context_commentstring = {
        enable = true
    }
}

