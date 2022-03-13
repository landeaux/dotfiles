local ls = require("luasnip")

local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local p = require("luasnip.extras").partial
local types = require("luasnip.util.types")

local my_utils = require("my.config.lsp.luasnip.utils")

vim.api.nvim_set_hl(0, "LuaSnipChoiceNodeVirtText", { fg = "#ff8800" })
vim.api.nvim_set_hl(0, "LuaSnipInsertNodeVirtText", { fg = "#4488ff" })

ls.config.set_config({
    history = true,
    store_selection_keys = "<CR>",
    -- Update more often, :h events for more info.
    updateevents = "TextChanged,TextChangedI",
    ext_opts = {
        [types.choiceNode] = {
            active = {
                virt_text = { { "●", "LuaSnipChoiceNodeVirtText" } },
            },
        },
        [types.insertNode] = {
            active = {
                virt_text = { { "●", "LuaSnipInsertNodeVirtText" } },
            },
        },
    },
    -- treesitter-hl has 100, use something higher (default is 200).
    ext_base_prio = 300,
    -- minimal increase in priority.
    ext_prio_increase = 1,
    -- enable_autosnippets = true,
})

ls.snippets = {
    -- When trying to expand a snippet, luasnip first searches the tables for
    -- each filetype specified in 'filetype' followed by 'all'.
    -- If ie. the filetype is 'lua.c'
    --     - luasnip.lua
    --     - luasnip.c
    --     - luasnip.all
    -- are searched in that order.
    all = {
        -- Use a function to execute any shell command and print its text.
        s("sh:tree", f(my_utils.bash, {}, { user_args = { "tree -L 2" } })),

        -- Directly insert the output from a function evaluated at runtime.
        s("dt:y", p(os.date, "%Y")),
        s("dt:ym", p(os.date, "%Y-%M")),
        s("dt:ymd", p(os.date, "%Y-%M-%d")),
        s("dt:ymdt", p(os.date, "%Y-%M-%dT%H:%M:%S")),
    },
    java = {
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
    },
}

-- NOTE: not really sure what this does
-- autotriggered snippets have to be defined in a separate table, luasnip.autosnippets.
-- ls.autosnippets = {
--     all = {
--         s("autotrigger", {
--             t("autosnippet"),
--         }),
--     },
-- }

--[[
-- Beside defining your own snippets you can also load snippets from "vscode-like" packages
-- that expose snippets in json files, for example <https://github.com/rafamadriz/friendly-snippets>.
-- Mind that this will extend  `ls.snippets` so you need to do it after your own snippets or you
-- will need to extend the table yourself instead of setting a new one.
]]

local custom_snippets_path = vim.fn.getenv("DOTFILES") .. "/snippets"
require("luasnip.loaders.from_vscode").lazy_load({ paths = { custom_snippets_path } })
require("luasnip.loaders.from_vscode").lazy_load() -- load plugin snippets
