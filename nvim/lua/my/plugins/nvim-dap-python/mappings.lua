local map = require("my.utils").map_factory({ buffer = true, silent = true })

local register_mappings = function()
    map("n", "<LocalLeader>dm", function()
        require("dap-python").test_method({})
    end, { desc = "Test method" })
    map("n", "<LocalLeader>dc", function()
        require("dap-python").test_class({})
    end, { desc = "Test class" })
    map(
        "v",
        "<LocalLeader>ds",
        '<ESC>:lua require("dap-python").debug_selection({})<CR>',
        { desc = "Debug selection" }
    )
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
