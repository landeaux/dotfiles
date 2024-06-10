local dap = require("dap")

local colors = {
    breakpoint_icon = "#aa0000",
    breakpoint_line = "#880000",
    conditional_breakpoint_icon = "#aa4400",
    conditional_breakpoint_line = "#884400",
    log_point_icon = "#aaaa00",
    log_point_line = "#888800",
    stopped_icon = "#0000aa",
    stopped_line = "#000088",
}

-- Customize symbols and highlights
vim.cmd("hi DapBreakpointIcon guifg=" .. colors.breakpoint_icon)
vim.cmd("hi DapBreakpointLine guibg=" .. colors.breakpoint_line)
vim.cmd("hi link DapBreakpointNumber DapBreakpointIcon")

vim.cmd("hi DapBreakpointConditionIcon guifg=" .. colors.conditional_breakpoint_icon)
vim.cmd("hi DapBreakpointConditionLine guibg=" .. colors.conditional_breakpoint_line)
vim.cmd("hi link DapBreakpointConditionNumber DapBreakpointConditionIcon")

vim.cmd("hi DapLogPointIcon guifg=" .. colors.log_point_icon)
vim.cmd("hi DapLogPointLine guibg=" .. colors.log_point_line)
vim.cmd("hi link DapLogPointNumber DapLogPointIcon")

vim.cmd("hi DapStoppedIcon guifg=" .. colors.stopped_icon)
vim.cmd("hi DapStoppedLine guibg=" .. colors.stopped_line .. " gui=bold")
vim.cmd("hi link DapStoppedNumber DapStoppedIcon")

vim.fn.sign_define("DapBreakpoint", {
    text = "",
    texthl = "DapBreakpointIcon",
    linehl = "DapBreakpointLine",
    numhl = "DapBreakpointNumber",
})
vim.fn.sign_define("DapBreakpointCondition", {
    text = "",
    texthl = "DapBreakpointConditionIcon",
    linehl = "DapBreakpointConditionLine",
    numhl = "DapBreakpointConditionNumber",
})
vim.fn.sign_define("DapLogPoint", {
    text = "",
    texthl = "DapLogPointIcon",
    linehl = "DapLogPointLine",
    numhl = "DapLogPointNumber",
})
vim.fn.sign_define("DapStopped", {
    text = "󰁕",
    texthl = "DapStoppedIcon",
    linehl = "DapStoppedLine",
    numhl = "DapStoppedNumber",
})

-- DAP REPL autocomplete
require("my.utils").create_augroup({
    {
        event = "FileType",
        opts = { pattern = "dap-repl", command = 'lua require("dap.ext.autocompl").attach()' },
    },
}, "_dap_repl")

-- DAP Terminal settings
-- @see :h dap-terminal
dap.defaults.fallback.external_terminal = {
    command = "kitty",
    args = {},
}
