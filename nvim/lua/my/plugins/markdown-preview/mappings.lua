local map = require("my.utils").map_factory({ remap = true, buffer = true, silent = true })

-- Markdown filetype settings
local function register_buffer_mappings()
    map("n", "<LocalLeader>p", "<Plug>MarkdownPreview")
    map("n", "<LocalLeader>s", "<Plug>MarkdownPreviewStop")
    map("n", "<LocalLeader>t", "<Plug>MarkdownPreviewToggle")
end

require("my.utils").create_augroup({
    {
        event = "FileType",
        opts = { pattern = "markdown", callback = register_buffer_mappings },
    },
}, "_markdown")
