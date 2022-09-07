local map = require("my.utils").map_factory({ remap = true, buffer = true, silent = true })

-- Markdown filetype settings
local function register_buffer_mappings()
    require("my.utils").set_buffer_soft_line_nagivation()

    map("n", "<LocalLeader>p", "<Plug>MarkdownPreview")
    map("n", "<LocalLeader>s", "<Plug>MarkdownPreviewStop")
    map("n", "<LocalLeader>t", "<Plug>MarkdownPreviewToggle")

    local ok, wk = pcall(require, "which-key")
    if ok then
        wk.register(
            { p = "Start Preview", s = "Stop preview", t = "Toggle preview" },
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
