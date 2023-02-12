local ls = require("luasnip")

local c = ls.choice_node
local d = ls.dynamic_node
local i = ls.insert_node
local sn = ls.snippet_node
local t = ls.text_node

local M = {}

-- args is a table, where 1 is the text in Placeholder 1, 2 the text in
-- placeholder 2,...
function M.copy(args)
    return args[1]
end

-- 'recursive' dynamic snippet. Expands to some text followed by itself.
M.rec_ls = function()
    return sn(
        nil,
        c(1, {
            -- Order is important, sn(...) first would cause infinite loop of expansion.
            t(""),
            sn(nil, { t({ "", "\t\\item " }), i(1), d(2, M.rec_ls, {}) }),
        })
    )
end

-- Make sure to not pass an invalid command, as io.popen() may write over nvim-text.
function M.bash(_, _, command)
    local file = io.popen(command, "r")
    local res = {}
    for line in file:lines() do
        table.insert(res, line)
    end
    return res
end

-- Returns a snippet_node wrapped around an insert_node whose initial
-- text value is set to the current date in the desired format.
function M.date_input(_, _, fmt)
    local _fmt = fmt or "%Y-%m-%d"
    return sn(nil, i(1, os.date(_fmt)))
end

return M
