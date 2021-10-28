local ok, err = pcall(require, "my")

if not ok then
    error(("Error loading core...\n\n%s"):format(err))
end
