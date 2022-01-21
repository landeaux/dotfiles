local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local wk = require("whichkey_setup")
local bind = vim.api.nvim_set_keymap
local custom_pickers = require("my.config.tools.telescope-pickers")

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
        file_ignore_patterns = { ".git/" },
        path_display = { "smart" },
        prompt_prefix = " ",
        selection_caret = " ",
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
        mappings = {
            i = {
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
                ["<C-f>"] = actions.preview_scrolling_down,
                ["<C-d>"] = actions.preview_scrolling_up,
                ["<CR>"] = actions.select_default + actions.center,
                ["<C-y>"] = set_prompt_to_entry_value,
            },
            n = {
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
    pickers = {
        current_buffer_fuzzy_find = {
            skip_empty_lines = true,
        },
        find_files = {
            hidden = true,
        },
        live_grep = {
            path_display = { "shorten" },
            mappings = {
                i = {
                    ["<c-e>"] = custom_pickers.actions.set_extension,
                    ["<c-l>"] = custom_pickers.actions.set_folders,
                },
            },
        },
        oldfiles = {
            sort_lastused = true,
            cwd_only = true,
        },
    },
})

-- Extensions
require("telescope").load_extension("dap")
require("telescope").load_extension("fzf")

-- Bindings
bind("n", "<Leader>f/", ":Telescope current_buffer_fuzzy_find<CR>", {})
bind("n", "<Leader>fa", ":Telescope builtin<CR>", {})
bind("n", "<Leader>fb", ":Telescope buffers<CR>", {})
bind("n", "<Leader>fc", ":Telescope commands<CR>", {})
bind("n", "<Leader>ff", ":Telescope find_files<CR>", {})
bind("n", "<Leader>fFi", ":Telescope find_files no_ignore=true<CR>", {})
-- bind("n", "<Leader>fF", ":Telescope find_files search_dirs=", {})
bind("n", "<Leader>fg", ":lua require('my.config.tools.telescope-pickers').live_grep()<CR>", {})
-- bind(
--     "n",
--     "<Leader>fGf",
--     ":lua require('my.config.tools.telescope-pickers').live_grep_in_folder()<CR>",
--     {}
-- )
bind(
    "n",
    "<Leader>fGi",
    ':Telescope live_grep vimgrep_arguments={"rg","--color=never","--no-heading","--with-filename","--line-number","--column","--smart-case","-u"}<CR>',
    {}
)
bind("n", "<Leader>fh", ":Telescope help_tags<CR>", {})
bind("n", "<Leader>fo", ":Telescope oldfiles<CR>", {})
bind("n", "<Leader>ft", ":Telescope treesitter<CR>", {})
bind("n", "<Leader>fw", ":Telescope grep_string<CR>", {})
bind("v", "<Leader>f", '"zy:Telescope live_grep default_text=<C-r>z<CR>', {})

-- DAP
bind("n", "<Leader>fdc", ":Telescope dap commands<CR>", {})
bind("n", "<Leader>fds", ":Telescope dap configurations<CR>", {})
bind("n", "<Leader>fdl", ":Telescope dap list_breakpoints<CR>", {})
bind("n", "<Leader>fdv", ":Telescope dap variables<CR>", {})
bind("n", "<Leader>fdf", ":Telescope dap frames<CR>", {})

wk.register_keymap("leader", {
    f = {
        name = "+telescope",
        ["/"] = "Current buffer fuzzy find",
        a = "Builtins",
        b = "Buffers",
        f = "Find files",
        F = {
            name = "+find_files",
            i = "No ignore",
        },
        g = "Live grep",
        G = {
            name = "+live_grep",
            -- f = "In folder(s)",
            i = "No ignore",
        },
        h = "Help tags",
        o = "Old files",
        t = "Treesitter",
        w = "Find word under cursor",
        -- Extensions
        d = {
            name = "+dap",
            c = "Commands",
            s = "Configurations",
            l = "List breakpoints",
            v = "Variables",
            f = "Frames",
        },
    },
})
wk.register_keymap("visual", {
    f = "Live grep visual selection",
})
