local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local wk = require("whichkey_setup")
local bind = vim.api.nvim_set_keymap

local set_prompt_to_entry_value = function(prompt_bufnr)
    local entry = action_state.get_selected_entry()
    if not entry or not type(entry) == "table" then
        return
    end

    action_state.get_current_picker(prompt_bufnr):reset_prompt(entry.ordinal)
end

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
        layout_strategy = "flex",
        layout_config = {
            width = 0.95,
            height = 0.85,
            prompt_position = "top",

            horizontal = {
                width = 0.9,
                preview_cutoff = 60,
                preview_width = function(_, cols, _)
                    if cols > 200 then
                        return math.floor(cols * 0.7)
                    else
                        return math.floor(cols * 0.6)
                    end
                end,
            },
            vertical = {
                width = 0.75,
                height = 0.85,
                preview_height = 0.4,
                mirror = true,
            },
            flex = {
                -- change to horizontal after 120 cols
                flip_columns = 120,
            },
        },
        file_sorter = require("telescope.sorters").get_fzy_sorter,
        -- file_sorter = require("telescope.sorters").get_fuzzy_file,
        file_ignore_patterns = {},
        generic_sorter = require("telescope.sorters").get_fzy_sorter,
        -- generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
        -- path_display = { shorten = 3 },
        path_display = { "smart" },
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
                ["<C-f>"] = actions.preview_scrolling_down,
                ["<C-d>"] = actions.preview_scrolling_up,

                -- To disable a keymap, put [map] = false
                -- So, to not map "<C-n>", just put
                -- ["<c-x>"] = false,

                -- Otherwise, just set the mapping to the function that you want it to be.
                -- ["<C-i>"] = actions.select_horizontal,

                -- Add up multiple actions
                ["<CR>"] = actions.select_default + actions.center,
                ["<C-y>"] = set_prompt_to_entry_value,
                -- You can perform as many actions in a row as you like
                -- ["<CR>"] = actions.select_default + actions.center + my_cool_custom_action,
            },
            n = {
                -- ["<C-i>"] = my_cool_custom_action,
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
                ["<C-f>"] = actions.preview_scrolling_down,
                ["<C-d>"] = actions.preview_scrolling_up,
                ["q"] = actions.close,
            },
        },
    },
    extensions = {
        fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case", -- or "ignore_case" or "respect_case"
        },
    },
})

-- Extensions
require("telescope").load_extension("dap")
require("telescope").load_extension("fzf")

local bind_picker = require("my.config.tools.telescope-nvim-utils").bind_picker

-- Alt-Shift-P command palette
bind_picker("<S-A-p>", "commands")

-- Normal
bind_picker("<Leader>f.", "file_browser")
bind_picker("<Leader>f/", "current_buffer_fuzzy_find")
bind_picker("<Leader>fa", "builtin")
bind_picker("<Leader>fb", "buffers")
bind_picker("<Leader>ff", "find_files")
bind_picker("<Leader>fg", "live_grep")
bind_picker("<Leader>fh", "help_tags")
bind_picker("<Leader>fo", "oldfiles")
bind_picker("<Leader>ft", "treesitter")
bind_picker("<Leader>fw", "grep_string")

-- bind("n", "<Leader>fF", ":Telescope find_files search_dirs=", {})
bind("n", "<Leader>fF", ":Telescope find_files no_ignore=true<CR>", {})
bind(
    "n",
    "<Leader>fG",
    ':Telescope live_grep vimgrep_arguments={"rg","--color=never","--no-heading","--with-filename","--line-number","--column","--smart-case","-u"}<CR>',
    {}
)
bind("v", "<Leader>f", '"zy:Telescope live_grep default_text=<C-r>z<CR>', {})

local keys = {
    f = {
        name = "+telescope",
        ["/"] = "Current buffer fuzzy find",
        a = "Builtins",
        b = "Buffers",
        f = "Find files",
        F = "Find files (include ignored)",
        g = "Live grep",
        G = "Live grep (include ignored)",
        h = "Help tags",
        o = "Old files",
        t = "Treesitter",
        w = "Find word under cursor",
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

wk.register_keymap("leader", keys)
wk.register_keymap("visual", {
    f = "Live grep visual selection",
})
