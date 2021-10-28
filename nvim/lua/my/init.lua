-- Set mapleader to space
vim.g.mapleader = " "

-- Set localleader to comma
vim.g.maplocalleader = ","

local cosmic_modules = {
    "my.disabled",
    "my.settings",
    "my.autocmd",
    "my.plugins",
    "my.keybinds",
    "my.config",
}

for _, mod in ipairs(cosmic_modules) do
    local ok, err = pcall(require, mod)
    if not ok then
        error(("Error loading %s...\n\n%s"):format(mod, err))
    end
end
