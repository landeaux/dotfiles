vim.keymap.set("n", "<Leader>tu", ":UndotreeToggle<CR>")

local ok, wk = pcall(require, "which-key")
if ok then
    wk.register({
        t = { name = "+ui-toggle", u = "UndoTree" },
    }, {
        prefix = "<leader>",
    })
end
