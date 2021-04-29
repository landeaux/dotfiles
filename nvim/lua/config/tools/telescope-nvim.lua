local actions = require('telescope.actions')

-- Telescope setup
require('telescope').setup{
    defaults = {
        vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case'
        },

        prompt_position = "top",
        prompt_prefix = " ",

        selection_caret = " ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "ascending",

        layout_strategy = "horizontal",

        layout_defaults = {
            horizontal = {
                mirror = false,
            },
            vertical = {
                mirror = false,
            },
        },

        file_sorter =  require'telescope.sorters'.get_fzy_sorter,
        file_ignore_patterns = {},

        generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
        shorten_path = true,
        winblend = 0,
        width = 0.75,
        preview_cutoff = 120,

        results_height = 1,
        results_width = 0.8,

        border = {},
        borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },

        color_devicons = true,
        use_less = true,
        set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,

        file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
        grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
        qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,

        -- Developer configurations: Not meant for general override
        buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker,

        mappings = {
            i = {
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
                -- To disable a keymap, put [map] = false
                -- So, to not map "<C-n>", just put
                -- ["<c-x>"] = false,
                ["<esc>"] = actions.close,

                -- Otherwise, just set the mapping to the function that you want it to be.
                -- ["<C-i>"] = actions.select_horizontal,

                -- Add up multiple actions
                ["<CR>"] = actions.select_default + actions.center

                -- You can perform as many actions in a row as you like
                -- ["<CR>"] = actions.select_default + actions.center + my_cool_custom_action,
            },
            n = {
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
                -- ["<C-i>"] = my_cool_custom_action,
            }
        }
    }
}

-- Telescope modules
require('telescope').load_extension('dap')

local bind_picker = require('config.tools.telescope-nvim-utils').bind_picker

-- Alt-Shift-P command palette
bind_picker('<S-A-p>', 'commands')

-- Normal
bind_picker('<Leader>ff', 'find_files')
bind_picker('<Leader>fg', 'live_grep')
bind_picker('<Leader>fb', 'buffers')
bind_picker('<Leader>fh', 'help_tags')
bind_picker('<Leader>ft', 'treesitter')
bind_picker('<Leader>fo', 'oldfiles')
bind_picker('<Leader>fa', 'builtin')

local keys = {
    f = {
        name = '+telescope',
        b = 'Buffers',
        f = 'Find files',
        g = 'Live grep',
        h = 'Help tags',
        t = 'Treesitter',
        o = 'Old files',
        a = 'Builtins'
    }
}

-- DAP
bind_picker('<Leader>dc', 'commands', 'dap')
bind_picker('<Leader>ds', 'configurations', 'dap')
bind_picker('<Leader>dl', 'list_breakpoints', 'dap')
bind_picker('<Leader>dv', 'variables', 'dap')
bind_picker('<Leader>df', 'frames', 'dap')

keys.d = {
    name = '+dap',
    c = 'Commands',
    s = 'Configurations',
    l = 'List breakpoints',
    v = 'Variables',
    f = 'Frames'
}

require('whichkey_setup').register_keymap('leader', keys)
