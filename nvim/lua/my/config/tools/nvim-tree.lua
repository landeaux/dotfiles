local g = vim.g
local bind = vim.api.nvim_set_keymap
local lib = require("nvim-tree.lib")
local utils = require("nvim-tree.utils")

-- Custom callbacks
function _NvimTreeSearch(search_type)
    local supported_search_types = { "find_files", "live_grep" }

    if not vim.tbl_contains(supported_search_types, search_type) then
        vim.notify("'" .. search_type .. "' is not a supported search_type")
        return
    end

    local node = lib.get_node_at_cursor()
    if not node then
        return
    end

    local absolute_path = node.absolute_path
    local relative_path = utils.path_relative(absolute_path, lib.Tree.cwd)
    local search_dir = node.entries ~= nil and utils.path_add_trailing(relative_path)
        or relative_path

    vim.cmd("Telescope " .. search_type .. " search_dirs=" .. search_dir)
end

function NvimTreeLiveGrep()
    return _NvimTreeSearch("live_grep")
end

function NvimTreeFindFiles()
    return _NvimTreeSearch("find_files")
end

g.nvim_tree_indent_markers = 1 -- shows indent markers when folders are open
-- g.nvim_tree_git_hl = 1 -- enable file highlight for git attributes (can be used without the icons)
-- g.nvim_tree_highlight_opened_files = 1 -- enable folder and file icon highlight for opened files/directories.
g.nvim_tree_disable_window_picker = 1

require("nvim-tree").setup({
    actions = {
        open_file = {
            quit_on_open = true,
        },
    },
    diagnostics = { enable = true },
    disable_netrw = false,
    filters = {
        dotfiles = false,
        custom = { ".git", "node_modules", ".cache" },
    },
    hijack_cursor = false, -- NOTE: setting this to true breaks stuff
    update_focused_file = {
        enable = true,
    },
    view = {
        width = 45,
        mappings = {
            list = {
                { key = { "ff" }, cb = ":lua NvimTreeFindFiles()<cr>", mode = "n" },
                { key = { "fg" }, cb = ":lua NvimTreeLiveGrep()<cr>", mode = "n" },
            },
        },
    },
})

-- Mappings
bind("n", "<Leader>tn", ":NvimTreeToggle<CR>", { noremap = true })
require("whichkey_setup").register_keymap("leader", {
    t = { name = "+ui-toggle", n = "NvimTree" },
})
