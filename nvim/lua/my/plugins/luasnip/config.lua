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
})

ls.add_snippets("all", require("my.plugins.luasnip.snippets.all"))
ls.add_snippets("python", require("my.plugins.luasnip.snippets.python"))

local custom_snippets_path = vim.fn.expand("~/.dotfiles/snippets")
require("luasnip.loaders.from_vscode").lazy_load({ paths = { custom_snippets_path } })
require("luasnip.loaders.from_vscode").lazy_load() -- load plugin snippets
