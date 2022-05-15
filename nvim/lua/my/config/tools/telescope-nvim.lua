local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local wk = require("which-key")
local map = vim.keymap.set
local custom_pickers = require("my.config.tools.telescope-pickers")

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
        file_ignore_patterns = { ".git/" },
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

-- Bindings
map("n", "<Leader>f/", ":Telescope current_buffer_fuzzy_find<CR>")
map("n", "<Leader>fa", ":Telescope builtin<CR>")
map("n", "<Leader>fb", ":Telescope buffers<CR>")
map("n", "<Leader>fc", ":Telescope commands<CR>")
map("n", "<Leader>ff", ":Telescope find_files<CR>")
map("n", "<Leader>fFi", ":Telescope find_files no_ignore=true<CR>")
-- bind("n", "<Leader>fF", ":Telescope find_files search_dirs=", {})
map("n", "<Leader>fg", require("my.config.tools.telescope-pickers").live_grep)
-- bind(
--     "n",
--     "<Leader>fGf",
--     ":lua require('my.config.tools.telescope-pickers').live_grep_in_folder()<CR>",
--     {}
-- )
map("n", "<Leader>fGi", function()
    require("telescope.builtin").live_grep({
        vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "-u",
        },
    })
end)
map("n", "<Leader>fed", ":Telescope diagnostics bufnr=0<CR>")
map("n", "<Leader>few", ":Telescope diagnostics<CR>")
map("n", "<Leader>fh", ":Telescope help_tags<CR>")
map("n", "<Leader>fo", ":Telescope oldfiles<CR>")
map("n", "<Leader>ft", ":Telescope treesitter<CR>")
map("n", "<Leader>fw", ":Telescope grep_string<CR>")
map("v", "<Leader>f", '"zy:Telescope live_grep default_text=<C-r>z<CR>')

-- DAP
map("n", "<Leader>fdc", ":Telescope dap commands<CR>")
map("n", "<Leader>fdf", ":Telescope dap frames<CR>")
map("n", "<Leader>fdl", ":Telescope dap list_breakpoints<CR>")
map("n", "<Leader>fds", ":Telescope dap configurations<CR>")
map("n", "<Leader>fdv", ":Telescope dap variables<CR>")

wk.register({
    f = {
        name = "+telescope",
        ["/"] = "Current buffer fuzzy find",
        a = "Builtins",
        b = "Buffers",
        e = {
            name = "+diagnostics",
            d = "Document Diagnostics",
            w = "Workspace Diagnostics",
        },
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
}, {
    prefix = "<leader>",
})

wk.register({
    f = "Live grep visual selection",
}, { mode = "v", prefix = "<leader>" })
