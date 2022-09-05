vim.keymap.set("n", "<Leader>tn", ":Neotree filesystem reveal left toggle<CR>", { silent = true })

local ok, wk = pcall(require, "which-key")
if ok then
    wk.register({
        t = { name = "+ui-toggle", n = "File Tree" },
    }, {
        prefix = "<leader>",
    })
end
