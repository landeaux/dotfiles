local utils = require("my.utils")

-- Highlight text on yank
utils.create_augroup({
    {
        event = "TextYankPost",
        opts = {
            pattern = "*",
            callback = function() vim.highlight.on_yank() end,
        },
    },
}, "_highlight_on_yank")

utils.create_augroup({
    {
        event = "FileType",
        opts = {
            pattern = "markdown",
            callback = function() utils.set_buffer_soft_line_nagivation() end,
        },
    },
}, "_markdown_nav")

utils.create_augroup({
    -- clear any mappings on <CR> (e.g. Treesitter incremental selection)
    {
        event = "CmdWinEnter",
        opts = {
            callback = function() vim.keymap.del("n", "<CR>", { buffer = true }) end,
        },
    },
}, "_cmd_win")

utils.create_augroup({
    {
        event = "VimResized",
        opts = {
            callback = function()
                local current_tab = vim.fn.tabpagenr()
                vim.cmd("tabdo wincmd =")
                vim.cmd("tabnext " .. current_tab)
            end,
        },
    },
}, "_resize_splits")

-- vim.api.nvim_create_autocmd("ColorScheme", {
--     pattern = "kanagawa",
--     callback = function()
--         if vim.o.background == "light" then
--             vim.fn.system("kitty +kitten themes Kanagawa_light")
--         elseif vim.o.background == "dark" then
--             vim.fn.system("kitty +kitten themes Kanagawa_dragon")
--         else
--             vim.fn.system("kitty +kitten themes Kanagawa")
--         end
--     end,
-- })
