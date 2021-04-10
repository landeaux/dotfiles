local ts_config = require('nvim-treesitter.configs')

ts_config.setup {
    ensure_installed = {
        'bash',
        'css',
        'graphql',
        'html',
        'javascript',
        'lua',
        'python',
        'scss',
        'vue',
    },
    highlight = {
        enable = true,
        use_languagetree = true
    },
    context_commentstring = {
        enable = true,
        config = {
            vue = {
              style_element = '// %s',
            }
        }
    }
}

