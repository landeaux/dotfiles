local config = require("kommentary.config")

config.configure_language({ "javascript", "typescript" }, {
    prefer_single_line_comments = true,
    single_line_comment_string = "auto",
    multi_line_comment_strings = "auto",
})
config.configure_language({ "javascriptreact", "typescriptreact", "vue" }, {
    hook_function = function()
        require("ts_context_commentstring.internal").update_commentstring({})
    end,
    prefer_single_line_comments = true,
    single_line_comment_string = "auto",
    multi_line_comment_strings = "auto",
})
config.configure_language(
    "lua",
    { single_line_comment_string = "--", prefer_single_line_comments = true }
)
config.configure_language("php", {
    single_line_comment_string = "//",
    prefer_single_line_comments = true,
})
-- config.configure_language("smarty", {
--     multi_line_comment_strings = {"<!--", "-->"},
--     prefer_multi_line_comments = true,
-- })
