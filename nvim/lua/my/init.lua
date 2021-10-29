local my_modules = {
    "my.disabled",
    "my.settings",
    "my.pluginsInit",
    "my.config",
    "my.compiled",
    "my.autocmd",
    "my.keybinds",
}

for _, mod in ipairs(my_modules) do
    local ok, err = pcall(require, mod)
    if not ok then
        error(("Error loading %s...\n\n%s"):format(mod, err))
    end
end
