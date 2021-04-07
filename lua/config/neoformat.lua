local utils = require('utils')

local execute = vim.api.nvim_exec

utils.map('n', '<leader>fm', '<cmd>Neoformat<CR>')

execute(
  [[
    augroup fmt
      au!
      au BufWritePre * undojoin | Neoformat
    augroup END
  ]],
 false
)
