local g = vim.g
local dap = require('dap')

-- Enable DAP virtual text
g.dap_virtual_text = true

-- DAP REPL autocomplete
require('utils').create_augroup({
    {'FileType', 'dap-repl', 'lua require("dap.ext.autocompl").attach()'}
}, 'dap_repl')

-- DAP Terminal settings
local external_terminal = nil
if vim.g.os == "Linux" then
    external_terminal = {
        command = '/usr/bin/gnome-terminal';
        args = {'-e'};
    }
elseif vim.g.os == "Darwin" then
    external_terminal = {
        command = '/Applications/iTerm.app/Contents/MacOS/iTerm2';
        args = {};
    }
end
dap.defaults.fallback.external_terminal = external_terminal
