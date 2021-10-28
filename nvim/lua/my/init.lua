-- Set mapleader to space
vim.g.mapleader = " "

-- Set localleader to comma
vim.g.maplocalleader = ","

local my_modules = {
    "my.disabled",
    "my.settings",
    "my.autocmd",
    "my.pluginsInit",
    "my.compiled",
    "my.keybinds",
    "my.config",
}

for _, mod in ipairs(my_modules) do
    local ok, err = pcall(require, mod)
    if not ok then
        error(("Error loading %s...\n\n%s"):format(mod, err))
    end
end
