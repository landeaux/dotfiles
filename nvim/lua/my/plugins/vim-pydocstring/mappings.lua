local register_mappings = function()
    local map = vim.keymap.set
    map("n", "<leader>pl", "<Plug>(pydocstring)", {
        remap = true,
        silent = true,
        desc = "Add docstring to function or class under the cursor",
    })
    map(
        "n",
        "<leader>pf",
        ":PydocstringFormat<CR>",
        { silent = true, desc = "Add docstrings to all functions and classes in the file" }
    )
    map("v", "<leader>p", ":'<,'>Pydocstring<CR>", {
        silent = true,
        desc = "Add python docstring to the function or class inside visual selection",
    })

    local ok, wk = pcall(require, "which-key")
    if ok then
        wk.register({ p = { name = "+pydocstring" } }, { prefix = "<leader>" })
    end
end

require("my.utils").create_augroup({
    {
        event = "FileType",
        opts = {
            pattern = "python",
            callback = register_mappings,
        },
    },
}, "_pydocstring")
