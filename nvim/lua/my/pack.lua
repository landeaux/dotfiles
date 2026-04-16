-- User commands wrapping vim.pack.
local M = {}

local function managed() return vim.pack.get() end

local function names_where(predicate)
    local names = {}
    for _, p in ipairs(managed()) do
        if predicate(p) then
            table.insert(names, p.spec.name)
        end
    end
    table.sort(names)
    return names
end

local function active_names()
    return names_where(function(p) return p.active end)
end

local function orphan_names()
    return names_where(function(p) return not p.active end)
end

local function all_names()
    return names_where(function() return true end)
end

local function confirm_yes(msg) return vim.fn.confirm(msg, "&Yes\n&No", 2) == 1 end

local function short_rev(rev)
    if not rev or rev == "" then
        return "-"
    end
    return rev:sub(1, 7)
end

local function version_str(spec)
    local v = spec.version
    if v == nil then
        return ""
    end
    if type(v) == "string" then
        return v
    end
    return "<range>"
end

local function read_lockfile()
    local path = vim.fs.joinpath(vim.fn.stdpath("config"), "nvim-pack-lock.json")
    local ok_read, data = pcall(vim.fn.readfile, path)
    if not ok_read then
        return nil
    end
    local ok_decode, decoded = pcall(vim.fn.json_decode, data)
    if not ok_decode then
        return nil
    end
    local result = {}
    for name, entry in pairs(decoded.plugins or {}) do
        result[name] = entry.rev
    end
    return result
end

local function pad(s, width)
    s = tostring(s or "")
    if #s >= width then
        return s
    end
    return s .. string.rep(" ", width - #s)
end

local function render_table(headers, rows)
    local widths = {}
    for i, h in ipairs(headers) do
        widths[i] = #h
    end
    for _, row in ipairs(rows) do
        for i, cell in ipairs(row) do
            local len = #tostring(cell or "")
            if len > widths[i] then
                widths[i] = len
            end
        end
    end

    local lines = {}
    local header_parts = {}
    for i, h in ipairs(headers) do
        table.insert(header_parts, pad(h, widths[i]))
    end
    table.insert(lines, table.concat(header_parts, "  "))

    local sep_parts = {}
    for i in ipairs(headers) do
        table.insert(sep_parts, string.rep("-", widths[i]))
    end
    table.insert(lines, table.concat(sep_parts, "  "))

    for _, row in ipairs(rows) do
        local cells = {}
        for i, cell in ipairs(row) do
            table.insert(cells, pad(cell, widths[i]))
        end
        table.insert(lines, table.concat(cells, "  "))
    end
    return lines
end

local function open_scratch(lines, filetype)
    vim.cmd.new()
    local buf = vim.api.nvim_get_current_buf()
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    vim.api.nvim_set_option_value("buftype", "nofile", { buf = buf })
    vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = buf })
    vim.api.nvim_set_option_value("swapfile", false, { buf = buf })
    vim.api.nvim_set_option_value("modifiable", false, { buf = buf })
    if filetype then
        vim.api.nvim_set_option_value("filetype", filetype, { buf = buf })
    end
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = buf, nowait = true, silent = true })
end

local function collect_rows(include_lockfile)
    local lockfile = include_lockfile and read_lockfile() or nil
    local active_rows, orphan_rows = {}, {}
    for _, p in ipairs(managed()) do
        local row = {
            p.spec.name,
            short_rev(p.rev),
            p.active and "active" or "orphan",
            version_str(p.spec),
        }
        if include_lockfile then
            local lock_rev = lockfile and lockfile[p.spec.name] or nil
            local lock_short = lock_rev and short_rev(lock_rev) or "-"
            local drift
            if not lockfile or lock_rev == nil then
                drift = "?"
            elseif lock_rev == p.rev then
                drift = "="
            else
                drift = "≠"
            end
            table.insert(row, lock_short)
            table.insert(row, drift)
        end
        if p.active then
            table.insert(active_rows, row)
        else
            table.insert(orphan_rows, row)
        end
    end
    local function by_name(a, b) return a[1] < b[1] end
    table.sort(active_rows, by_name)
    table.sort(orphan_rows, by_name)
    local all = {}
    vim.list_extend(all, active_rows)
    vim.list_extend(all, orphan_rows)
    return all, lockfile
end

local function filter_prefix(list, prefix)
    if not prefix or prefix == "" then
        return list
    end
    local out = {}
    for _, name in ipairs(list) do
        if vim.startswith(name, prefix) then
            table.insert(out, name)
        end
    end
    return out
end

local function complete_active(arglead) return filter_prefix(active_names(), arglead) end

local function complete_all(arglead) return filter_prefix(all_names(), arglead) end

-- expose internals for later tasks to reference without re-declaring
M._internal = {
    active_names = active_names,
    all_names = all_names,
    orphan_names = orphan_names,
    confirm_yes = confirm_yes,
    complete_active = complete_active,
    complete_all = complete_all,
    collect_rows = collect_rows,
    render_table = render_table,
    open_scratch = open_scratch,
}

vim.api.nvim_create_user_command("PackList", function()
    local headers = { "NAME", "REV", "STATE", "VERSION" }
    local rows = collect_rows(false)
    open_scratch(render_table(headers, rows), "packlist")
end, { nargs = 0 })

vim.api.nvim_create_user_command("PackStatus", function()
    local headers = { "NAME", "REV", "STATE", "VERSION", "LOCKFILE", "DRIFT" }
    local rows, lockfile = collect_rows(true)
    local lines = render_table(headers, rows)
    if not lockfile then
        table.insert(lines, 1, "WARNING: nvim-pack-lock.json missing or unparseable")
        table.insert(lines, 2, "")
    end
    open_scratch(lines, "packstatus")
end, { nargs = 0 })

vim.api.nvim_create_user_command("PackUpdate", function(opts)
    local names = (#opts.fargs > 0) and opts.fargs or nil
    vim.pack.update(names, { force = opts.bang })
end, { nargs = "*", bang = true, complete = complete_active })

vim.api.nvim_create_user_command("PackRemove", function(opts)
    local managed_set = {}
    for _, n in ipairs(all_names()) do
        managed_set[n] = true
    end
    local to_remove, skipped = {}, {}
    for _, name in ipairs(opts.fargs) do
        if managed_set[name] then
            table.insert(to_remove, name)
        else
            table.insert(skipped, name)
        end
    end
    if #to_remove > 0 then
        vim.pack.del(to_remove)
    end
    if not opts.bang then
        local parts = {}
        if #to_remove > 0 then
            table.insert(parts, ("Removed: %s"):format(table.concat(to_remove, ", ")))
            table.insert(
                parts,
                "Remember to remove their specs from pluginsInit.lua or they'll be reinstalled on next startup."
            )
        end
        if #skipped > 0 then
            table.insert(parts, ("Skipped (not managed): %s"):format(table.concat(skipped, ", ")))
        end
        if #parts > 0 then
            vim.notify(table.concat(parts, "\n"), vim.log.levels.INFO)
        end
    end
end, { nargs = "+", bang = true, complete = complete_all })

return M
