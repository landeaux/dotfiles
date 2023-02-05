if vim.version().minor < 7 then
    vim.notify("Current NVIM version is <0.7! Some features may not work...", vim.log.levels.WARN)
end

local ok, err = pcall(require, "my")

if not ok then
    error(("Error loading core...\n\n%s"):format(err))
end
