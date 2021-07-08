local actions = require("telescope.actions")

-- Telescope setup
require("telescope").setup({
    defaults = {
        vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
        },
        prompt_prefix = " ",
        selection_caret = " ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
            prompt_position = "top",
            horizontal = {
                mirror = false,
            },
            vertical = {
                mirror = false,
            },
            height = 0.80,
        },
        file_sorter = require("telescope.sorters").get_fzy_sorter,
        -- file_sorter = require("telescope.sorters").get_fuzzy_file,
        file_ignore_patterns = {},
        generic_sorter = require("telescope.sorters").get_fzy_sorter,
        -- generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
        path_display = { "shorten" },
        winblend = 0,
        border = {},
        -- borderchars = {'▄', '▌', '▀', '▐', '▗', '▖', '▘', '▝'},
        -- borderchars = {'━', '┃', '━', '┃', '┏', '┓', '┛', '┗'},
        -- borderchars = {'─', '│', '─', '│', '┌', '┐', '┘', '└'},
        -- borderchars = {'═', '║', '═', '║', '╔', '╗', '╝', '╚'},
        -- borderchars = {'═', '│', '═', '│', '╒', '╕', '╛', '╘'},
        -- borderchars = {'─', '║', '─', '║', '╓', '╖', '╜', '╙'},
        -- borderchars = {'⠉', '⢸', '⣀', '⡇', '⡏', '⢹', '⣸', '⣇'},
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        color_devicons = true,
        use_less = true,
        set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,

        -- Developer configurations: Not meant for general override
        buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,

        mappings = {
            i = {
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,

                -- To disable a keymap, put [map] = false
                -- So, to not map "<C-n>", just put
                -- ["<c-x>"] = false,

                -- Otherwise, just set the mapping to the function that you want it to be.
                -- ["<C-i>"] = actions.select_horizontal,

                -- Add up multiple actions
                ["<CR>"] = actions.select_default + actions.center,

                -- You can perform as many actions in a row as you like
                -- ["<CR>"] = actions.select_default + actions.center + my_cool_custom_action,
            },
            n = {
                -- ["<C-i>"] = my_cool_custom_action,
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
                ["q"] = actions.close,
            },
        },
    },
})

-- Telescope modules
require("telescope").load_extension("dap")

local bind_picker = require("config.tools.telescope-nvim-utils").bind_picker

-- Alt-Shift-P command palette
bind_picker("<S-A-p>", "commands")

-- Normal
bind_picker("<Leader>f/", "current_buffer_fuzzy_find")
bind_picker("<Leader>fa", "builtin")
bind_picker("<Leader>fb", "buffers")
bind_picker("<Leader>ff", "find_files")
bind_picker("<Leader>fg", "live_grep")
bind_picker("<Leader>fh", "help_tags")
bind_picker("<Leader>fo", "oldfiles")
bind_picker("<Leader>ft", "treesitter")

local keys = {
    f = {
        name = "+telescope",
        ["/"] = "Current buffer fuzzy find",
        a = "Builtins",
        b = "Buffers",
        f = "Find files",
        g = "Live grep",
        h = "Help tags",
        o = "Old files",
        t = "Treesitter",
    },
}

-- DAP
bind_picker("<Leader>fdc", "commands", "dap")
bind_picker("<Leader>fds", "configurations", "dap")
bind_picker("<Leader>fdl", "list_breakpoints", "dap")
bind_picker("<Leader>fdv", "variables", "dap")
bind_picker("<Leader>fdf", "frames", "dap")

keys.f.d = {
    name = "+dap",
    c = "Commands",
    s = "Configurations",
    l = "List breakpoints",
    v = "Variables",
    f = "Frames",
}

require("whichkey_setup").register_keymap("leader", keys)
