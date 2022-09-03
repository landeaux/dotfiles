local map = vim.keymap.set
local opts = { silent = true }

-- DAP
map("n", "<Leader>dc", function()
    require("dap").continue()
end, opts)
map("n", "<Leader>dC", function()
    require("my.plugins.dap.utils").reload_continue()
end, opts)
map("n", "<Leader>dj", function()
    require("dap").step_over()
end, opts)
map("n", "<Leader>dl", function()
    require("dap").step_into()
end, opts)
map("n", "<Leader>dk", function()
    require("dap").step_out()
end, opts)
map("n", "<Leader>dt", function()
    require("dap").toggle_breakpoint()
end, opts)
map("n", "<Leader>dbc", function()
    require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, opts)
map("n", "<Leader>dbl", function()
    require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
end, opts)
map("n", "<Leader>dbe", function()
    require("dap").set_exception_breakpoints({ "all" })
end, opts)
map("n", "<Leader>dr", ':lua require("dap").repl.open({}, "vsplit")<CR><C-w>l', opts)
map("n", "<Leader>dR", function()
    require("dap").run_last()
end, opts)
map("n", "<Leader>d?", function()
    require("dap.ui.variables").scopes()
end, opts)
map("n", "<Leader>di", function()
    require("dap.ui.variables").hover(function()
        return vim.fn.expand("<cexpr>")
    end)
end, opts)
map("v", "<Leader>di", function()
    require("dap.ui.variables").visual_hover()
end, opts)
map("n", "<Leader>dh", function()
    require("dap.ui.widgets").hover()
end, opts)
map("n", "<Leader>df", function()
    local widgets = require("dap.ui.widgets")
    widgets.centered_float(widgets.scopes)
end, opts)

local keys = {
    d = {
        name = "+dap",
        c = "Continue",
        C = "Reload continue",
        j = "Step over",
        l = "Step into",
        k = "Step out",
        t = "Toggle breakpoint",
        b = {
            name = "+breakpoint",
            c = "Conditional breakpoint",
            e = "Exception breakpoints",
            l = "Log point",
        },
        r = "Open REPL",
        R = "Run last",
        ["?"] = "Variable scopes",
        i = "Variable info",
        h = "Widget hover",
        f = "Widget float",
    },
}

local visual_keys = { d = { name = "+dap", i = "Variable info" } }

require("which-key").register(keys, { prefix = "<leader>" })
require("which-key").register(visual_keys, { mode = "v", prefix = "<leader>" })
