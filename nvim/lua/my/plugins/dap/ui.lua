local dap, dapui = require("dap"), require("dapui")

dapui.setup()

-- Open on start
dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open({})
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close({})
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close({})
end

vim.keymap.set("n", "<Leader>du", function()
    dapui.toggle({})
end, { silent = true })

require("which-key").register({
    d = {
        name = "+dap",
        u = "Toggle DAP UI",
    },
}, {
    prefix = "<leader>",
})
