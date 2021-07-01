local g = vim.g
local dap = require("dap")
local colors = require("config.ui.colorscheme").colors

-- Enable DAP virtual text
g.dap_virtual_text = true

-- Customize symbols and highlights
vim.cmd("hi DapBreakpointIcon guifg=" .. colors.breakpoint_icon_color)
vim.cmd("hi DapBreakpointLine guibg=" .. colors.breakpoint_line_color)
vim.cmd("hi link DapBreakpointNumber DapBreakpointIcon")
vim.cmd("hi DapStoppedIcon guifg=" .. colors.stopped_icon_color)
vim.cmd("hi DapStoppedLine guibg=" .. colors.stopped_line_color .. " gui=bold")
vim.cmd("hi link DapStoppedNumber DapStoppedIcon")

vim.fn.sign_define("DapBreakpoint", {
    text = "",
    texthl = "DapBreakpointIcon",
    linehl = "DapBreakpointLine",
    numhl = "DapBreakpointNumber",
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
