local register_mappings = function()
    local map = vim.keymap.set
    local opts = { buffer = true, silent = true }
    local dap_python = require("dap-python")

    map("n", "<LocalLeader>dm", dap_python.test_method, opts)
    map("n", "<LocalLeader>dc", dap_python.test_class, opts)
    map("v", "<LocalLeader>ds", '<ESC>:lua require("dap-python").debug_selection()<CR>', opts)

    local keys = { d = { name = "+dap", m = "Test method", c = "Test class" } }
    local visual_keys = { d = { name = "+dap", s = "Debug selection" } }
    local wk = require("which-key")

    wk.register(keys, { prefix = "<localleader>" })
    wk.register(visual_keys, { mode = "v", prefix = "<localleader>" })
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
