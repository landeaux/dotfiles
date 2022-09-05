local map = vim.keymap.set

map("n", "<Leader>gvc", ":GV!<CR>")
map("n", "<Leader>gvl", ":GV?<CR>")
map("n", "<Leader>gvo", ":GV<CR>")

local ok, wk = pcall(require, "which-key")
if ok then
    wk.register({
        g = {
            name = "+git",
            v = {
                name = "+commit-browser",
                c = "List commits that affected current file",
                l = "Fill location list with revisions of current file",
                o = "Open commit browser",
            },
        },
    }, { prefix = "<leader>" })
end
