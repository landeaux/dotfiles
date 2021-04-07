vim.g.mapleader = ' '

local fn = vim.fn
local execute = vim.api.nvim_command

vim.g.python_host_prog = "~/.pyenv/versions/neovim-python2/bin/python"
vim.g.python3_host_prog = "~/.pyenv/versions/neovim-python3/bin/python"

require('settings')

-- Automatically install packer.nvim
local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
end

-- auto compile when there are changes in plugins.lua
vim.cmd 'autocmd BufWritePost plugins.lua PackerCompile'

-- Install plugins
require('plugins')

-- Key mappings
require('keymappings')

-- Autocommands
require('autocmd')

-- Language server config
-- require('lang')

-- Config
require('config')

