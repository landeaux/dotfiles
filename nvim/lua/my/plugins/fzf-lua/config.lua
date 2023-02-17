local fzf_lua = require("fzf-lua")
local utils = require("fzf-lua.utils")
local actions = require("fzf-lua.actions")

local function lastIndexOf(haystack, needle)
    local i = haystack:match(".*" .. needle .. "()")
    if i == nil then
        return nil
    else
        return i - 1
    end
end

local function stripBeforeLastOccurrenceOf(str, sep)
    local idx = lastIndexOf(str, sep) or 0
    return str:sub(idx + 1), idx
end

local grep_dir = function(selected, opts)
    local globs = ""
    for i = 1, #selected do
        opts = opts or {}
        -- Remove ansi coloring and prefixed icons
        local stripped = utils.strip_ansi_coloring(selected[i])
        stripped, _ = stripBeforeLastOccurrenceOf(stripped, utils.nbsp)
        globs = globs .. "--glob '" .. stripped .. "**' "
    end

    local o = vim.tbl_extend("keep", {
        -- debug = true,
        rg_glob = false,
        rg_opts = "--column --line-number --no-heading --color=always --smart-case "
            .. "--max-columns=512 "
            .. globs,
    }, {})

    fzf_lua.live_grep(o)
end

fzf_lua.setup({
    file_ignore_patterns = { ".git/", "dotbot/", "mariadb/data/", "^dist.*/" },
    winopts = {
        preview = {
            flip_columns = 250,
        },
    },
    actions = {
        files = {
            -- it's important to define all other actions here as this
            -- table does not get merged with the global defaults
            ["default"] = actions.file_edit_or_qf,
            ["ctrl-s"] = actions.file_split,
            ["ctrl-v"] = actions.file_vsplit,
            ["ctrl-t"] = actions.file_tabedit,
            ["alt-q"] = actions.file_sel_to_qf,
            ["alt-l"] = actions.file_sel_to_ll,
            -- custom
            ["ctrl-g"] = grep_dir,
        },
    },
    grep = {
        rg_glob = true,
    },
    oldfiles = {
        cwd_only = true,
    },
})
