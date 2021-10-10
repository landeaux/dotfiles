local g = vim.g
local dap = require("dap")
local colors = require("config.ui.colorscheme").colors

-- Enable DAP virtual text
g.dap_virtual_text = true

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
require("utils").create_augroup(
    { { "FileType", "dap-repl", 'lua require("dap.ext.autocompl").attach()' } },
    "dap_repl"
)

-- DAP Terminal settings
local external_terminal = nil
if vim.g.os == "Linux" then
    external_terminal = { command = "/usr/bin/gnome-terminal", args = { "-e" } }
elseif vim.g.os == "Darwin" then
    external_terminal = { command = "/Applications/iTerm.app/Contents/MacOS/iTerm2", args = {} }
end
dap.defaults.fallback.external_terminal = external_terminal
