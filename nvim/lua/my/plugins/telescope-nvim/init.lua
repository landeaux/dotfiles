local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local custom_pickers = require("my.plugins.telescope-pickers")

local set_prompt_to_entry_value = function(prompt_bufnr)
    local entry = action_state.get_selected_entry()
    if not entry or not type(entry) == "table" then
        return
    end

    action_state.get_current_picker(prompt_bufnr):reset_prompt(entry.ordinal)
end

local previewers = require("telescope.previewers")
local new_maker = function(filepath, bufnr, opts)
    opts = opts or {}

    filepath = vim.fn.expand(filepath)
    vim.loop.fs_stat(filepath, function(_, stat)
        if not stat then
            return
        end
        if stat.size > 100000 then
            return
        else
            previewers.buffer_previewer_maker(filepath, bufnr, opts)
        end
    end)
end

-- Telescope setup
require("telescope").setup({
    defaults = {
        file_ignore_patterns = { ".git/", "dotbot/" },
        path_display = { "smart" },
        buffer_previewer_maker = new_maker,
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
