local map = require("my.utils").map_factory({ silent = true })

map("n", "<Leader>dc", function()
    require("dap").continue()
end, { desc = "DAP: Continue" })

map("n", "<Leader>dC", function()
    require("dap").run_last()
end, { desc = "DAP: Run last" })

map("n", "<Leader>dr", ':lua require("dap").repl.open({}, "vsplit")<CR><C-w>li', { desc = "DAP: Open DAP REPL" })

map("n", "<Leader>dj", function()
    require("dap").step_over()
end, { desc = "DAP: Step over" })

map("n", "<Leader>dk", function()
    require("dap").step_back()
end, { desc = "DAP: Step back" })

map("n", "<Leader>dl", function()
    require("dap").step_into()
end, { desc = "DAP: Step into" })

map("n", "<Leader>dh", function()
    require("dap").step_out()
end, { desc = "DAP: Step out" })

map("n", "<Leader>dt", function()
    require("dap").toggle_breakpoint()
end, { desc = "DAP: Toggle breakpoint" })

map("n", "<Leader>dbc", function()
    require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, {
    desc = "DAP: Set conditional breakpoint",
})

map("n", "<Leader>dbl", function()
    require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
end, {
    desc = "DAP: Set breakpoint with log",
})

map("n", "<Leader>dbe", function()
    require("dap").set_exception_breakpoints({ "all" })
end, {
    desc = "DAP: Set exception breakpoint",
})

map("n", "<Leader>ds", function()
    local widgets = require("dap.ui.widgets")
    widgets.centered_float(widgets.scopes)
end, {
    desc = "DAP: View scopes",
})

map("n", "<Leader>df", function()
    local widgets = require("dap.ui.widgets")
    widgets.centered_float(widgets.frames)
end, {
    desc = "DAP: View frames",
})

map("n", "<Leader>dT", function()
    local widgets = require("dap.ui.widgets")
    widgets.centered_float(widgets.threads)
end, {
    desc = "DAP: View threads",
})

map({ "n", "v" }, "<Leader>dK", function()
    require("dap.ui.widgets").hover()
end, { desc = "DAP: Expression hover" })
