local map = vim.keymap.set

map(
    "n",
    "<Leader>gvc",
    ":GV!<CR>",
    { silent = true, desc = "List commits that affected current file" }
)
map(
    "n",
    "<Leader>gvl",
    ":GV?<CR>",
    { silent = true, desc = "Fill location list with revisions of current file" }
)
map("n", "<Leader>gvo", ":GV<CR>", { silent = true, desc = "Open commit browser" })

local ok, wk = pcall(require, "which-key")
if ok then
    wk.register({
        g = {
            name = "+git",
            v = {
                name = "+commit-browser",
            },
        },
    }, { prefix = "<leader>" })
end
