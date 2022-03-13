local ls = require("luasnip")

local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local d = ls.dynamic_node

local my_utils = require("my.config.lsp.luasnip.utils")

return {
    -- Very long example for a java class.
    s("fn", {
        d(6, my_utils.jdocsnip, { 2, 4, 5 }),
        t({ "", "" }),
        c(1, {
            t("public "),
            t("private "),
        }),
        c(2, {
            t("void"),
            t("String"),
            t("char"),
            t("int"),
            t("double"),
            t("boolean"),
            i(nil, ""),
        }),
        t(" "),
        i(3, "myFunc"),
        t("("),
        i(4),
        t(")"),
        c(5, {
            t(""),
            sn(nil, {
                t({ "", " throws " }),
                i(1),
            }),
        }),
        t({ " {", "\t" }),
        i(0),
        t({ "", "}" }),
    }),
}
