local g = vim.g
local dap = require("dap")

-- Enable DAP virtual text
g.dap_virtual_text = true

-- Customize symbols and highlights
vim.cmd("hi DapBreakpointIcon guifg=#bf616a")
vim.cmd("hi DapBreakpointLine guibg=#bf616a")
vim.cmd("hi link DapBreakpointNumber DapBreakpointIcon")

vim.cmd("hi DapStoppedIcon guifg=#558d9d")
vim.cmd("hi DapStoppedLine guibg=#225a6a gui=bold")
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
