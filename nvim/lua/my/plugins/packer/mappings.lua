local packer_sync = function()
    vim.notify("Syncing packer.", "info", { title = "Packer" })
    local snap_shot_time = os.date("!%Y-%m-%dT%TZ")
    vim.cmd("PackerSnapshot " .. snap_shot_time)
    vim.cmd("PackerSync")
end

vim.keymap.set("n", "<leader>ps", "", {
    callback = packer_sync,
}, { desc = "Sync Packer" })

local ok, wk = pcall(require, "which-key")
if ok then
    wk.register({ p = { name = "+packer" } }, { prefix = "<leader>" })
end
