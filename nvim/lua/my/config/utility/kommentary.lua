local bind = vim.api.nvim_set_keymap
local config = require("kommentary.config")
local wk = require("whichkey_setup")

local js_ts_react_config = {
    prefer_single_line_comments = true,
    single_line_comment_string = "auto",
    multi_line_comment_strings = "auto",
}
config.configure_language("javascript", js_ts_react_config)
config.configure_language("typescript", js_ts_react_config)
config.configure_language("javascriptreact", js_ts_react_config)
config.configure_language("typescriptreact", js_ts_react_config)
config.configure_language("vue", {
    hook_function = function()
        require("ts_context_commentstring.internal").update_commentstring()
    end,
    single_line_comment_string = "auto",
    multi_line_comment_strings = "auto",
    prefer_single_line_comments = true,
})
config.configure_language(
    "lua",
    { single_line_comment_string = "--", prefer_single_line_comments = true }
)
config.configure_language("php", {
    single_line_comment_string = "//",
    prefer_single_line_comments = true,
})

bind("n", "<leader>/", "<Plug>kommentary_line_default", {})
bind("n", "<leader>cct", "<Plug>kommentary_line_default", {})
bind("n", "<leader>cci", "<Plug>kommentary_line_increase", {})
bind("n", "<leader>ccd", "<Plug>kommentary_line_decrease", {})

bind("n", "<leader>ct", "<Plug>kommentary_motion_default", {})
bind("n", "<leader>ci", "<Plug>kommentary_motion_increase", {})
bind("n", "<leader>cd", "<Plug>kommentary_motion_decrease", {})

bind("v", "<leader>/", "<Plug>kommentary_visual_default", {})
bind("v", "<leader>ct", "<Plug>kommentary_visual_default", {})
bind("v", "<leader>ci", "<Plug>kommentary_visual_increase", {})
bind("v", "<leader>cd", "<Plug>kommentary_visual_decrease", {})

wk.register_keymap("leader", {
    ["/"] = "Toggle commenting level for line",
    c = {
        name = "+comment",
        i = "Increase commenting level for motion",
        d = "Decrease commenting level for motion",
        t = "Toggle commenting level for motion",
        c = {
            name = "+line",
            i = "Increase commenting level for line",
            d = "Decrease commenting level for line",
            t = "Toggle commenting level for line",
        },
    },
})

wk.register_keymap("visual", {
    ["/"] = "Toggle commenting level",
    c = {
        name = "+comment",
        i = "Increase commenting level",
        d = "Decrease commenting level",
        t = "Toggle commenting level",
    },
})