local bind = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

local g = vim.g

g.dashboard_custom_header = {
    " ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
    " ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
    " ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
    " ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
    " ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
    " ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝",
}

g.dashboard_default_executive = "telescope"

g.dashboard_custom_section = {
    a = { description = { "  Find File          " }, command = "Telescope find_files" },
    b = { description = { "  Recently Used Files" }, command = "Telescope oldfiles" },
    c = { description = { "  Find Word          " }, command = "Telescope live_grep" },
    d = { description = { "  New File           " }, command = "DashboardNewFile" },
    e = { description = { "  Load Last Session  " }, command = "SessionLoad" },
    f = { description = { "  Marks              " }, command = "Telescope marks" },
    g = {
        description = { "  Settings           " },
        command = ":e ~/.config/nvim/lua/settings.lua",
    },
}

g.dashboard_custom_footer = { "You aren't going to need it." }

bind("n", "<leader>;", ":Dashboard<CR>", opts)

bind("n", "<leader>ss", ":<C-u>SessionSave<CR>", {})
bind("n", "<leader>sl", ":<C-u>SessionLoad<CR>", {})

local keys = {
    [";"] = "Go to Dashboard",
    s = { name = "+session", l = "Load session", s = "Save session" },
}

require("whichkey_setup").register_keymap("leader", keys)
