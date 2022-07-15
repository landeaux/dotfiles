local dap = require("dap")
local colors = require("my.config.ui.colors")

-- Customize symbols and highlights
vim.cmd("hi DapBreakpointIcon guifg=" .. colors.debugging.breakpoint_icon)
vim.cmd("hi DapBreakpointLine guibg=" .. colors.debugging.breakpoint_line)
vim.cmd("hi link DapBreakpointNumber DapBreakpointIcon")

vim.cmd("hi DapBreakpointConditionIcon guifg=" .. colors.debugging.conditional_breakpoint_icon)
vim.cmd("hi DapBreakpointConditionLine guibg=" .. colors.debugging.conditional_breakpoint_line)
vim.cmd("hi link DapBreakpointConditionNumber DapBreakpointConditionIcon")

vim.cmd("hi DapLogPointIcon guifg=" .. colors.debugging.log_point_icon)
vim.cmd("hi DapLogPointLine guibg=" .. colors.debugging.log_point_line)
vim.cmd("hi link DapLogPointNumber DapLogPointIcon")

vim.cmd("hi DapStoppedIcon guifg=" .. colors.debugging.stopped_icon)
vim.cmd("hi DapStoppedLine guibg=" .. colors.debugging.stopped_line .. " gui=bold")
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
    text = "",
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
