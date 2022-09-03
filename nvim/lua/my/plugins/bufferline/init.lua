require("bufferline").setup({
    options = {
        numbers = function(opts)
            return string.format("%s", opts.raise(opts.ordinal))
        end, -- "none" | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level, diagnostics_dict)
            local icon = level:match("error") and " " or " "
            return " " .. icon .. count
        end,
        -- NOTE: this will be called a lot so don't do any heavy processing here
        custom_filter = function(buf_number)
            -- Filter out terminal buffers
            if vim.bo[buf_number].buftype ~= "terminal" then
                return true
            end
        end,
        offsets = { { filetype = "neo-tree", text = "File Explorer", text_align = "left" } },
        show_buffer_close_icons = false,
        show_close_icon = false,
        separator_style = "thin", -- "slant" | "thick" | "thin" | { 'any', 'any' },
        sort_by = "insert_at_end",
    },
})
