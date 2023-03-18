local my_modules = {
    "my.disabled",
    "my.settings",
    "my.diagnostics",
    "my.scratch",
    "my.buf_only",
    "my.pluginsInit",
    "my.autocmd",
    "my.mappings",
}

for _, mod in ipairs(my_modules) do
    local ok, err = pcall(require, mod)
    if not ok then
        error(("Error loading %s...\n\n%s"):format(mod, err))
    end
end
