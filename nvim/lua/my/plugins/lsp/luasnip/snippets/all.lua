local ls = require("luasnip")

local s = ls.snippet
local f = ls.function_node
local p = require("luasnip.extras").partial

local my_utils = require("my.plugins.lsp.luasnip.utils")

return {
    -- Use a function to execute any shell command and print its text.
    s("shtree", f(my_utils.bash, {}, { user_args = { "tree -L 2" } })),

    -- Directly insert the output from a function evaluated at runtime.
    s("dty", p(os.date, "%Y")),
    s("dtym", p(os.date, "%Y-%M")),
    s("dtymd", p(os.date, "%Y-%M-%d")),
    s("dtymdt", p(os.date, "%Y-%M-%dT%H:%M:%S")),
}
