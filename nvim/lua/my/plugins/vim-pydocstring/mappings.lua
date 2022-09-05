local map = vim.keymap.set
local opts = { silent = true }

map("n", "<leader>pl", "<Plug>(pydocstring)", opts)
map("n", "<leader>pf", ":PydocstringFormat<CR>", opts)
map("v", "<leader>p", ":'<,'>Pydocstring<CR>", opts)

local ok, wk = pcall(require, "which-key")
if ok then
    wk.register({
        p = {
            name = "+pydocstring",
            l = "Add docstring to function or class under the cursor",
            f = "Add docstrings to all functions and classes in the file",
        },
    }, {
        prefix = "<leader>",
    })

    wk.register({
        p = "Add python docstring to the function or class inside visual selection",
    }, {
        mode = "v",
        prefix = "<leader>",
    })
end
