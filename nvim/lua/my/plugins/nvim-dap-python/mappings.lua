local register_mappings = function()
    local map = vim.keymap.set
    local opts = { buffer = true, silent = true }
    local dap_python = require("dap-python")

    map("n", "<LocalLeader>dm", dap_python.test_method, opts)
    map("n", "<LocalLeader>dc", dap_python.test_class, opts)
    map("v", "<LocalLeader>ds", '<ESC>:lua require("dap-python").debug_selection()<CR>', opts)

    local ok, wk = pcall(require, "which-key")
    if ok then
        wk.register(
            { d = { name = "+dap", m = "Test method", c = "Test class" } },
            { prefix = "<localleader>" }
        )
        wk.register(
            { d = { name = "+dap", s = "Debug selection" } },
            { mode = "v", prefix = "<localleader>" }
        )
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
