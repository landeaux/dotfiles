local utils = require('utils')

utils.map('n', '<leader>gs', '<cmd>G<CR>')
utils.map('n', '<leader>gb', '<cmd>Git blame<CR>')

utils.map('n', '<leader>gf', '<cmd>diffget //2<CR>')
utils.map('n', '<leader>gj', '<cmd>diffget //3<CR>')
