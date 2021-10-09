-- Set mapleader to space
vim.g.mapleader = " "

-- Set localleader to comma
vim.g.maplocalleader = ","

-- Sensible defaults
require("settings")

-- Autocmd
require("autocmd")

-- Load plugins
require("plugins")

-- Load keybinds
require("keybinds")

-- Load configuration
require("plugins.config")
