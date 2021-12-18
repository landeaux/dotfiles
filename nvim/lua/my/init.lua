local my_modules = {
    "my.disabled",
    "my.settings",
    "my.pluginsInit",
    "my.autocmd",
    "my.keybinds",
}

for _, mod in ipairs(my_modules) do
    local ok, err = pcall(require, mod)
    if not ok then
        error(("Error loading %s...\n\n%s"):format(mod, err))
    end
end

-- use pcall on compiled.lua in case it doesn't exist already
local packer_compiled, _ = pcall(require, "my.compiled")
if not packer_compiled then
    local packer_exists, _ = pcall(require, "packer")
    if packer_exists then
        vim.cmd("PackerCompile")
    end
end
