-- Markdown filetype settings
local function register_buffer_mappings()
    require("my.utils").set_buffer_soft_line_nagivation()

    local map = vim.keymap.set
    local opts = { buffer = true }

    map("n", "<LocalLeader>p", "<Plug>MarkdownPreview", opts)
    map("n", "<LocalLeader>s", "<Plug>MarkdownPreviewStop", opts)
    map("n", "<LocalLeader>t", "<Plug>MarkdownPreviewToggle", opts)

    local ok, wk = pcall(require, "which-key")
    if ok then
        wk.register(
            { p = "Preview", s = "Stop preview", t = "Toggle preview" },
            { prefix = "<localleader>" }
        )
    end
end

require("my.utils").create_augroup({
    {
        event = "FileType",
        opts = { pattern = "markdown", callback = register_buffer_mappings },
    },
}, "_markdown")
