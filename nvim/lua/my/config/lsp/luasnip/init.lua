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

-- args is a table, where 1 is the text in Placeholder 1, 2 the text in
-- placeholder 2,...
local function copy(args)
    return args[1]
end

-- 'recursive' dynamic snippet. Expands to some text followed by itself.
local rec_ls
rec_ls = function()
    return sn(
        nil,
        c(1, {
            -- Order is important, sn(...) first would cause infinite loop of expansion.
            t(""),
            sn(nil, { t({ "", "\t\\item " }), i(1), d(2, rec_ls, {}) }),
        })
    )
end

-- complicated function for dynamicNode.
local function jdocsnip(args, _, old_state)
    -- !!! old_state is used to preserve user-input here. DON'T DO IT THAT WAY!
    -- Using a restoreNode instead is much easier.
    -- View this only as an example on how old_state functions.
    local nodes = {
        t({ "/**", " * " }),
        i(1, "A short Description"),
        t({ "", "" }),
    }

    -- These will be merged with the snippet; that way, should the snippet be updated,
    -- some user input eg. text can be referred to in the new snippet.
    local param_nodes = {}

    if old_state then
        nodes[2] = i(1, old_state.descr:get_text())
    end
    param_nodes.descr = nodes[2]

    -- At least one param.
    if string.find(args[2][1], ", ") then
        vim.list_extend(nodes, { t({ " * ", "" }) })
    end

    local insert = 2
    for indx, arg in ipairs(vim.split(args[2][1], ", ", true)) do
        -- Get actual name parameter.
        arg = vim.split(arg, " ", true)[2]
        if arg then
            local inode
            -- if there was some text in this parameter, use it as static_text for this new snippet.
            if old_state and old_state[arg] then
                inode = i(insert, old_state["arg" .. arg]:get_text())
            else
                inode = i(insert)
            end
            vim.list_extend(nodes, { t({ " * @param " .. arg .. " " }), inode, t({ "", "" }) })
            param_nodes["arg" .. arg] = inode

            insert = insert + 1
        end
    end

    if args[1][1] ~= "void" then
        local inode
        if old_state and old_state.ret then
            inode = i(insert, old_state.ret:get_text())
        else
            inode = i(insert)
        end

        vim.list_extend(nodes, { t({ " * ", " * @return " }), inode, t({ "", "" }) })
        param_nodes.ret = inode
        insert = insert + 1
    end

    if vim.tbl_count(args[3]) ~= 1 then
        local exc = string.gsub(args[3][2], " throws ", "")
        local ins
        if old_state and old_state.ex then
            ins = i(insert, old_state.ex:get_text())
        else
            ins = i(insert)
        end
        vim.list_extend(nodes, { t({ " * ", " * @throws " .. exc .. " " }), ins, t({ "", "" }) })
        param_nodes.ex = ins
        insert = insert + 1
    end

    vim.list_extend(nodes, { t({ " */" }) })

    local snip = sn(nil, nodes)
    -- Error on attempting overwrite.
    snip.old_state = param_nodes
    return snip
end

-- Make sure to not pass an invalid command, as io.popen() may write over nvim-text.
local function bash(a, b, command)
    local file = io.popen(command, "r")
    local res = {}
    for line in file:lines() do
        table.insert(res, line)
    end
    return res
end

-- Returns a snippet_node wrapped around an insert_node whose initial
-- text value is set to the current date in the desired format.
local date_input = function(args, state, fmt)
    local fmt = fmt or "%Y-%m-%d"
    return sn(nil, i(1, os.date(fmt)))
end

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
        s("sh:tree", f(bash, {}, { user_args = { "tree -L 2" } })),

        -- Directly insert the output from a function evaluated at runtime.
        s("dt:y", p(os.date, "%Y")),
        s("dt:ym", p(os.date, "%Y-%M")),
        s("dt:ymd", p(os.date, "%Y-%M-%d")),
        s("dt:ymdt", p(os.date, "%Y-%M-%dT%H:%M:%S")),
    },
    java = {
        -- Very long example for a java class.
        s("fn", {
            d(6, jdocsnip, { 2, 4, 5 }),
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
