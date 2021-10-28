-- Set mapleader to space
vim.g.mapleader = " "

-- Set localleader to comma
vim.g.maplocalleader = ","

-- Sensible defaults
require("my.settings")

-- Autocmd
require("my.autocmd")

-- Load plugins
require("my.plugins")

-- Load keybinds
require("my.keybinds")

-- Load configuration
require("my.config")
