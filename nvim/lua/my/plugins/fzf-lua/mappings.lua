local map = require("my.utils").map_factory({ silent = true })

-- files
map("n", "<Leader>ff", ":FzfLua files<CR>", { desc = "Find files" })
map("n", "<Leader>fo", ":FzfLua oldfiles<CR>", { desc = "Find previous files" })
map("n", "<Leader>fb", ":FzfLua buffers<CR>", { desc = "Find buffers" })
map("n", "<Leader>fF", function()
    require("fzf-lua").files({ fd_opts = "-c never -t f -L -H -I" })
end, {
    desc = "Find files (include ignored)",
})
map("n", "<Leader>fD", function()
    require("fzf-lua").files({ fd_opts = "-c never -t d -L" })
end, {
    desc = "Find directories",
})

-- grep
map("n", "<Leader>fg", ":FzfLua live_grep<CR>", { desc = "Live grep" })
-- map("n", "<Leader>fg", ":FzfLua live_grep_native<CR>", { desc = "Live grep" })
map("n", "<Leader>fG", function()
    require("fzf-lua").live_grep({
        rg_opts = "--column"
            .. " --line-number"
            .. " --no-heading"
            .. " --color=always"
            .. " --smart-case"
            .. " --max-columns=512"
            .. " --hidden"
            .. " --no-ignore"
            .. " --glob '!.git'"
            .. " -e",
    })
end, {
    desc = "Live grep (include ignored, except .git/)",
})
map("n", "<Leader>fw", ":FzfLua grep_cword<CR>", { desc = "Find word under cursor" })
map("n", "<Leader>fW", ":FzfLua grep_cWORD<CR>", { desc = "Find WORD under cursor" })
map("v", "<Leader>f", ":<C-U>FzfLua grep_visual<CR>", { desc = "Find visual selection" })
map("n", "<Leader>f/", ":FzfLua grep_curbuf<CR>", { desc = "Current buffer fuzzy find" })

-- diagnostics
map("n", "<Leader>fe", ":FzfLua diagnostics_document<CR>", { desc = "Find buffer diagnostics" })
map("n", "<Leader>fE", ":FzfLua diagnostics_workspace<CR>", { desc = "Find workspace diagnostics" })

-- misc.
map("n", "<Leader>fa", ":FzfLua builtin<CR>", { desc = "Find builtins" })
map("n", "<Leader>fc", ":FzfLua commands<CR>", { desc = "Find commands" })
map("n", "<Leader>fh", ":FzfLua help_tags<CR>", { desc = "Find help tags" })
map("n", "<Leader>fk", ":FzfLua keymaps<CR>", { desc = "Find keymaps" })

-- tmux
map("n", "<Leader>fx", ":FzfLua tmux_buffers<CR>", { desc = "Find tmux paste buffers" })

-- DAP
map("n", "<Leader>fdc", ":FzfLua dap_commands<CR>", { desc = "Find dap commands" })
map("n", "<Leader>fdf", ":FzfLua dap_frames<CR>", { desc = "Find dap frames" })
map("n", "<Leader>fdl", ":FzfLua dap_breakpoints<CR>", { desc = "Find dap breakpoints" })
map("n", "<Leader>fds", ":FzfLua dap_configurations<CR>", { desc = "Find dap configurations" })
map("n", "<Leader>fdv", ":FzfLua dap_variables<CR>", { desc = "Find dap variables" })

-- completion
map("i", "<C-x><C-f>", function()
    require("fzf-lua").complete_path()
end, {
    silent = true,
    desc = "Fuzzy complete path",
})
map("i", "<C-x><C-l>", function()
    require("fzf-lua").complete_line()
end, {
    silent = true,
    desc = "Fuzzy complete lines",
})
