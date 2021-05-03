-- DAP mapping
local bind = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

bind('n', '<leader>dc', ':lua require("dap").continue()<CR>', opts)
bind('n', '<leader>dC', ':lua require("config.dap.utils").reload_continue()<CR>', opts)
bind('n', '<leader>dj', ':lua require("dap").step_over()<CR>', opts)
bind('n', '<leader>dl', ':lua require("dap").step_into()<CR>', opts)
bind('n', '<leader>dk', ':lua require("dap").step_out()<CR>', opts)
bind('n', '<Leader>dt', ':lua require("dap").toggle_breakpoint()<CR>', opts)
bind('n', '<Leader>dbc',
    ':lua require("dap").set_breakpoint' ..
    '(vim.fn.input("Breakpoint condition: "))<CR>', opts)
bind('n', '<Leader>dbl',
    ':lua require("dap").set_breakpoint' ..
    '(nil, nil, vim.fn.input("Log point message: "))<CR>', opts)
bind('n', '<Leader>dr', [[:lua require("dap").repl.open({}, 'vsplit')<CR><C-w>l]], opts)
bind('n', '<Leader>dR', ':lua require("dap").run_last()<CR>', opts)
bind('n', '<leader>d?', ":lua require'dap.ui.variables'.scopes()<CR>", opts)

local keys = {
    d = {
        name = '+dap',
        c = 'Continue',
        C = 'Reload continue',
        j = 'Step over',
        l = 'Step into',
        k = 'Step out',
        t = 'Toggle breakpoint',
        b = {
            name = '+breakpoint',
            c = 'Conditional breakpoint',
            l = 'Log point'
        },
        r = 'Open REPL',
        R = 'Run last',
        ['?'] = 'Variable scopes',
    }
}

require('whichkey_setup').register_keymap('leader', keys)
