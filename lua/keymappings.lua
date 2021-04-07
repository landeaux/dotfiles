local utils = require('utils')

utils.map('n', '<leader>hl', '<cmd>set hlsearch!<CR>') -- toggle highlights
utils.map('n', '<leader>l', '<cmd>set list!<CR>') -- toggle visibility of whitespace chars
utils.map('n', '<leader>M', '<cmd>e ~/.config/nvim/init.lua<CR>') -- edit nvim config
utils.map('n', '<leader>R', '<cmd>luafile ~/.config/nvim/init.lua<CR>') -- reload nvim config

-- copying
utils.map('', '<leader>y', '"+y') -- copy any selected text to clipboard
utils.map('n', '<leader>a', '<cmd> %+y<CR>') -- copy any selected text to clipboard

-- terminals
utils.map('n', '<C-x>', [[<Cmd>vnew term://bash <CR>]]) -- open term over right
