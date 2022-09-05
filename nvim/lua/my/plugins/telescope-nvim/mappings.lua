local map = vim.keymap.set

map("n", "<Leader>f/", ":Telescope current_buffer_fuzzy_find<CR>")
map("n", "<Leader>fa", ":Telescope builtin<CR>")
map("n", "<Leader>fb", ":Telescope buffers<CR>")
map("n", "<Leader>fc", ":Telescope commands<CR>")
map("n", "<Leader>ff", ":Telescope find_files<CR>")
map("n", "<Leader>fFi", ":Telescope find_files no_ignore=true<CR>")
-- map("n", "<Leader>fF", ":Telescope find_files search_dirs=")
map("n", "<Leader>fg", function()
    require("my.plugins.telescope-pickers").live_grep()
end)
-- map(
--     "n",
--     "<Leader>fGf",
--     ":lua require('my.plugins.telescope-pickers').live_grep_in_folder()<CR>",
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

local ok, wk = pcall(require, "which-key")
if ok then
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
end
