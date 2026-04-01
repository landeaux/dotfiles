---@diagnostic disable-next-line: missing-fields
require("ts_context_commentstring").setup({
    enable_autocmd = false,
})
vim.g.skip_ts_context_commentstring_module = true

require("my.plugins.comment-nvim.config")
