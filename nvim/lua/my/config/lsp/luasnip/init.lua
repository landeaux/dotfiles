local ls = require("luasnip")
local types = require("luasnip.util.types")

vim.api.nvim_set_hl(0, "LuaSnipChoiceNodeVirtText", { fg = "#ff8800" })
vim.api.nvim_set_hl(0, "LuaSnipInsertNodeVirtText", { fg = "#4488ff" })

ls.config.set_config({
    history = true,
    store_selection_keys = "<CR>",
    updateevents = "TextChanged,TextChangedI", -- Update more often, :h events for more info.
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
    ext_base_prio = 300, -- treesitter-hl has 100, use something higher (default is 200).
    ext_prio_increase = 1, -- minimal increase in priority.
    -- enable_autosnippets = true,
})

ls.add_snippets("all", require("my.config.lsp.luasnip.snippets.all"))
ls.add_snippets("python", require("my.config.lsp.luasnip.snippets.python"))
ls.add_snippets("java", require("my.config.lsp.luasnip.snippets.java"))

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
