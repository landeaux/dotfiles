local fzf_lua = require("fzf-lua")
local utils = require("fzf-lua.utils")

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
    return str:sub(idx + 1)
end

local grep_dir = function(selected, opts)
    local globs = ""
    for i = 1, #selected do
        opts = opts or {}
        -- Remove ansi coloring and prefixed icons
        local stripped = utils.strip_ansi_coloring(selected[i])
        stripped = stripBeforeLastOccurrenceOf(stripped, utils.nbsp)
        globs = globs .. "--glob '" .. stripped .. "**' "
    end

    local o = vim.tbl_extend("keep", {
        -- debug = true,
        rg_glob = false,
        rg_opts = "--column --line-number --no-heading --color=always --smart-case " .. "--max-columns=512 " .. globs,
        prompt = "Rg>",
        winopts = {
            title = globs,
            title_pos = "center",
        },
    }, {})

    fzf_lua.live_grep(o)
end

fzf_lua.setup({
    file_ignore_patterns = { ".git/", "dotbot/", "mariadb/data/", "^dist.*/" },
    winopts = {
        preview = {
            layout = "vertical",
        },
    },
    files = {
        actions = {
            ["ctrl-d"] = grep_dir,
        },
    },
    diagnostics = {
        diag_source = true,
    },
    grep = {
        rg_glob = true,
    },
    oldfiles = {
        cwd_only = true,
        include_current_session = true,
    },
    previewers = {
        builtin = {
            extensions = {
                ["jpg"] = { "chafa" },
                ["jpeg"] = { "chafa" },
                ["png"] = { "chafa" },
                ["svg"] = { "chafa" },
            },
        },
    },
})
