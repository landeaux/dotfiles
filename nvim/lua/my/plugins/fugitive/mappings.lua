local map = vim.keymap.set

map("n", "<Leader>ga", ":Git add -p<CR>")
map("n", "<Leader>gb", ":Git blame<CR>")
map("n", "<Leader>gc", ":Git commit -v<CR>")
map("n", "<Leader>gd", ":Gdiffsplit<CR>")
map("n", "<Leader>gm", ":Git commit --amend<CR>")
map("n", "<Leader>gp", ":Git push<CR>")
map("n", "<Leader>gs", ":G<CR>")
map("n", "<Leader>gw", ":Gwrite<CR>")

local ok, wk = pcall(require, "which-key")
if ok then
    wk.register({
        g = {
            name = "+git",
            a = "Add",
            b = "Blame",
            c = "Commit",
            d = "Diff",
            m = "Amend",
            p = "Push",
            s = "Status",
            w = "Write",
        },
    }, { prefix = "<leader>" })
end
