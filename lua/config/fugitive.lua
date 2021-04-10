local utils = require('utils')

utils.map('n', '<leader>gs', '<cmd>Gstatus<CR>')

utils.map('n', '<leader>gf', '<cmd>diffget //2<CR>')
utils.map('n', '<leader>gj', '<cmd>diffget //3<CR>')
