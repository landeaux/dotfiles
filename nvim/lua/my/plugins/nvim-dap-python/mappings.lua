local register_mappings = function()
    local map = vim.keymap.set

    map("n", "<LocalLeader>dm", function()
        require("dap-python").test_method({})
    end, { buffer = true, silent = true, desc = "Test method" })
    map("n", "<LocalLeader>dc", function()
        require("dap-python").test_class({})
    end, { buffer = true, silent = true, desc = "Test class" })
    map(
        "v",
        "<LocalLeader>ds",
        '<ESC>:lua require("dap-python").debug_selection({})<CR>',
        { buffer = true, silent = true, desc = "Debug selection" }
    )

    local ok, wk = pcall(require, "which-key")
    if ok then
        wk.register({ d = { name = "+dap" } }, { prefix = "<localleader>" })
        wk.register({ d = { name = "+dap" } }, { mode = "v", prefix = "<localleader>" })
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
}, "_dap_python")
