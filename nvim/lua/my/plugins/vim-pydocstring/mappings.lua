local map = require("my.utils").map_factory({ silent = true })

local register_mappings = function()
    map("n", "<leader>pl", "<Plug>(pydocstring)", {
        remap = true,
        desc = "Add docstring to function/class under cursor",
    })
    map(
        "n",
        "<leader>pf",
        ":PydocstringFormat<CR>",
        { desc = "Add docstrings to all functions/classes in file" }
    )
    map("v", "<leader>p", ":'<,'>Pydocstring<CR>", {
        desc = "Add docstring to selected function/class",
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
