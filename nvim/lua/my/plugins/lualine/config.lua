local WIN_BREAKPOINT = 115
local MAX_BRANCH_LEN = 20

local function win_is_wide() return vim.api.nvim_win_get_width(0) >= WIN_BREAKPOINT end
local function win_is_narrow() return not win_is_wide() end

local function truncate(str, max_length)
    if str:len() > max_length then
        return str:sub(1, max_length - 1) .. "…"
    end
    return str
end

require("lualine").setup({
    options = {
        disabled_filetypes = { statusline = { "lazy" } },
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = {
            {
                "branch",
                fmt = function(str) return truncate(str, MAX_BRANCH_LEN) end,
            },
            "diff",
            {
                "diagnostics",
                symbols = {
                    error = " ",
                    warn = " ",
                    hint = " ",
                    info = " ",
                },
            },
        },
        lualine_c = {
            { "filename", path = 1, cond = win_is_wide },
            { "filename", path = 4, cond = win_is_narrow },
        },
        lualine_x = {
            { "lsp_status", icon = " ", cond = win_is_wide },
            { "filetype", cond = win_is_wide },
        },
        lualine_y = {
            { "lsp_status", icon = " ", cond = win_is_narrow },
            { "progress", cond = win_is_wide },
        },
        lualine_z = {
            { "filetype", cond = win_is_narrow },
            { "location", cond = win_is_wide },
        },
    },
    extensions = { "fugitive", "quickfix", "man", "neo-tree" },
})
