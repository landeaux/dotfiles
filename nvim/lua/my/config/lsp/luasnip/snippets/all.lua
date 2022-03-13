local ls = require("luasnip")

local s = ls.snippet
local f = ls.function_node
local p = require("luasnip.extras").partial

local my_utils = require("my.config.lsp.luasnip.utils")

return {
    -- Use a function to execute any shell command and print its text.
    s("sh:tree", f(my_utils.bash, {}, { user_args = { "tree -L 2" } })),

    -- Directly insert the output from a function evaluated at runtime.
    s("dt:y", p(os.date, "%Y")),
    s("dt:ym", p(os.date, "%Y-%M")),
    s("dt:ymd", p(os.date, "%Y-%M-%d")),
    s("dt:ymdt", p(os.date, "%Y-%M-%dT%H:%M:%S")),
}
