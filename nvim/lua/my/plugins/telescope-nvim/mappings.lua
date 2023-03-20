local map = require("my.utils").map_factory({ silent = true })

map("n", "<Leader>f/", ":Telescope current_buffer_fuzzy_find<CR>", { desc = "Current buffer fuzzy find" })
map("n", "<Leader>fa", ":Telescope builtin<CR>", { desc = "Find builtins" })
map("n", "<Leader>fb", ":Telescope buffers<CR>", { desc = "Find buffers" })
map("n", "<Leader>fc", ":Telescope commands<CR>", { desc = "Find commands" })
map("n", "<Leader>ff", ":Telescope find_files<CR>", { desc = "Find files" })
map("n", "<Leader>fF", ":Telescope find_files no_ignore=true<CR>", { desc = "Find files (include ignored)" })
map("n", "<Leader>fg", function()
    require("my.plugins.telescope-nvim.pickers").live_grep()
end, { desc = "Live grep" })
map("n", "<Leader>fG", function()
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
end, {
    desc = "Live grep (include ignored)",
})
map("n", "<Leader>fe", ":Telescope diagnostics bufnr=0<CR>", { desc = "Find diagnostics (buffer)" })
map("n", "<Leader>fE", ":Telescope diagnostics<CR>", { desc = "Find diagnostics (workspace)" })
map("n", "<Leader>fh", ":Telescope help_tags<CR>", { desc = "Find help tags" })
map("n", "<Leader>fk", ":Telescope keymaps<CR>", { desc = "Find keymaps" })
map("n", "<Leader>fo", ":Telescope oldfiles<CR>", { desc = "Find previous files" })
map("n", "<Leader>ft", ":Telescope treesitter<CR>", { desc = "Find treesitter nodes" })
map("n", "<Leader>fw", ":Telescope grep_string<CR>", { desc = "Find word under cursor" })
map(
    "v",
    "<Leader>f",
    '"zy:lua require("telescope.builtin").live_grep({ default_text=vim.fn.getreg("z") })<CR>',
    { desc = "Live grep selected text" }
)

-- DAP
map("n", "<Leader>fdc", ":Telescope dap commands<CR>", { desc = "Find dap commands" })
map("n", "<Leader>fdf", ":Telescope dap frames<CR>", { desc = "Find dap frames" })
map("n", "<Leader>fdl", ":Telescope dap list_breakpoints<CR>", { desc = "Find dap breakpoints" })
map("n", "<Leader>fds", ":Telescope dap configurations<CR>", { desc = "Find dap configurations" })
map("n", "<Leader>fdv", ":Telescope dap variables<CR>", { desc = "Find dap variables" })
