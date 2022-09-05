local map = vim.keymap.set

map(
    "n",
    "<Leader>f/",
    ":Telescope current_buffer_fuzzy_find<CR>",
    { silent = true, desc = "Current buffer fuzzy find" }
)
map("n", "<Leader>fa", ":Telescope builtin<CR>", { silent = true, desc = "Find builtins" })
map("n", "<Leader>fb", ":Telescope buffers<CR>", { silent = true, desc = "Find buffers" })
map("n", "<Leader>fc", ":Telescope commands<CR>", { silent = true, desc = "Find commands" })
map("n", "<Leader>ff", ":Telescope find_files<CR>", { silent = true, desc = "Find files" })
map(
    "n",
    "<Leader>fFi",
    ":Telescope find_files no_ignore=true<CR>",
    { silent = true, desc = "Find files (include ignored)" }
)
-- map("n", "<Leader>fF", ":Telescope find_files search_dirs=", { silent = true, desc = "Find files in directory" })
map("n", "<Leader>fg", function()
    require("my.plugins.telescope-pickers").live_grep()
end, { silent = true, desc = "Live grep" })
-- map(
--     "n",
--     "<Leader>fGf",
--     ":lua require('my.plugins.telescope-pickers').live_grep_in_folder()<CR>",
-- { silent = true, desc = "Live grep in folder(s)" })
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
end, { silent = true, desc = "Live grep (include ignored)" })
map(
    "n",
    "<Leader>fed",
    ":Telescope diagnostics bufnr=0<CR>",
    { silent = true, desc = "Find diagnostics (buffer)" }
)
map(
    "n",
    "<Leader>few",
    ":Telescope diagnostics<CR>",
    { silent = true, desc = "Find diagnostics (workspace)" }
)
map("n", "<Leader>fh", ":Telescope help_tags<CR>", { silent = true, desc = "Find help tags" })
map("n", "<Leader>fo", ":Telescope oldfiles<CR>", { silent = true, desc = "Find previous files" })
map(
    "n",
    "<Leader>ft",
    ":Telescope treesitter<CR>",
    { silent = true, desc = "Find treesitter nodes" }
)
map(
    "n",
    "<Leader>fw",
    ":Telescope grep_string<CR>",
    { silent = true, desc = "Find word under cursor" }
)
map(
    "v",
    "<Leader>f",
    '"zy:Telescope live_grep default_text=<C-r>z<CR>',
    { silent = true, desc = "Live grep selected text" }
)

-- DAP
map(
    "n",
    "<Leader>fdc",
    ":Telescope dap commands<CR>",
    { silent = true, desc = "Find dap commands" }
)
map("n", "<Leader>fdf", ":Telescope dap frames<CR>", { silent = true, desc = "Find dap frames" })
map(
    "n",
    "<Leader>fdl",
    ":Telescope dap list_breakpoints<CR>",
    { silent = true, desc = "Find dap breakpoints" }
)
map(
    "n",
    "<Leader>fds",
    ":Telescope dap configurations<CR>",
    { silent = true, desc = "Find dap configurations" }
)
map(
    "n",
    "<Leader>fdv",
    ":Telescope dap variables<CR>",
    { silent = true, desc = "Find dap variables" }
)

local ok, wk = pcall(require, "which-key")
if ok then
    wk.register({
        f = {
            name = "+telescope",
            e = {
                name = "+diagnostics",
            },
            F = {
                name = "+find_files",
            },
            G = {
                name = "+live_grep",
            },
            -- Extensions
            d = {
                name = "+dap",
            },
        },
    }, {
        prefix = "<leader>",
    })
end
