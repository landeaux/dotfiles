-- Make Terminal use GUI colors
vim.o.termguicolors = true

-- Set background color
vim.o.background = "dark"

-- Set colorscheme
local plugin_present, _ = pcall(require, "tokyonight")
if plugin_present then
    vim.cmd("colorscheme tokyonight")
end
