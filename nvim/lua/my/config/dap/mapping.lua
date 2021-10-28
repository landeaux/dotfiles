local bind = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- DAP
bind("n", "<Leader>dc", ':lua require("dap").continue()<CR>', opts)
bind("n", "<Leader>dC", ':lua require("my.config.dap.utils").reload_continue()<CR>', opts)
bind("n", "<Leader>dj", ':lua require("dap").step_over()<CR>', opts)
bind("n", "<Leader>dl", ':lua require("dap").step_into()<CR>', opts)
bind("n", "<Leader>dk", ':lua require("dap").step_out()<CR>', opts)
bind("n", "<Leader>dt", ':lua require("dap").toggle_breakpoint()<CR>', opts)
bind(
    "n",
    "<Leader>dbc",
    ':lua require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>',
    opts
)
bind(
    "n",
    "<Leader>dbl",
    ':lua require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>',
    opts
)
bind("n", "<Leader>dbe", ':lua require("dap").set_exception_breakpoints({"all"})<CR>', opts)
bind("n", "<Leader>dr", ':lua require("dap").repl.open({}, "vsplit")<CR><C-w>l', opts)
bind("n", "<Leader>dR", ':lua require("dap").run_last()<CR>', opts)

-- DAP UI
bind("n", "<Leader>du", ':lua require("dapui").toggle()<CR>', opts)
bind("n", "<Leader>d?", ':lua require("dap.ui.variables").scopes()<CR>', opts)
bind(
    "n",
    "<Leader>di",
    ':lua require("dap.ui.variables").hover(function () return vim.fn.expand("<cexpr>") end)<CR>',
    opts
)
bind("v", "<Leader>di", ':lua require("dap.ui.variables").visual_hover()<CR>', opts)
bind("n", "<Leader>dh", ':lua require("dap.ui.widgets").hover()<CR>', opts)
bind(
    "n",
    "<Leader>df",
    ':lua local widgets=require("dap.ui.widgets");widgets.centered_float(widgets.scopes)<CR>',
    opts
)

-- Toggle folding
bind("n", "<Space><Space>", "za", opts)
bind("v", "<Space><Space>", "za", opts)

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
        u = "Toggle DAP UI",
        ["?"] = "Variable scopes",
        i = "Variable info",
        h = "Widget hover",
        f = "Widget float",
    },
}

local visual_keys = { d = { name = "+dap", i = "Variable info" } }

require("whichkey_setup").register_keymap("leader", keys)
require("whichkey_setup").register_keymap("visual", visual_keys)
