if vim.fn.has("nvim-0.6") == 0 then
    vim.notify("Current NVIM version is <0.6! Some features may not work...", vim.log.levels.WARN)
end

do
    local ok, _ = pcall(require, "impatient")

    if not ok then
        vim.notify("impatient.nvim not installed", vim.log.levels.WARN)
    end
end

local ok, err = pcall(require, "my")

if not ok then
    error(("Error loading core...\n\n%s"):format(err))
end
