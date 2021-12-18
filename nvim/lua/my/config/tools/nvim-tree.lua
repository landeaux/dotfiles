-- Nvim Tree
local g = vim.g
local bind = vim.api.nvim_set_keymap
local lib = require("nvim-tree.lib")
local utils = require("nvim-tree.utils")

g.nvim_tree_gitignore = 1
g.nvim_tree_quit_on_open = 1 -- closes the tree when you open a file
g.nvim_tree_indent_markers = 1 -- shows indent markers when folders are open
g.nvim_tree_git_hl = 1 -- enable file highlight for git attributes (can be used without the icons)
g.nvim_tree_highlight_opened_files = 1 -- enable folder and file icon highlight for opened files/directories.
g.nvim_tree_root_folder_modifier = ":~" -- see :help filename-modifiers for more options
g.nvim_tree_add_trailing = 0 -- append a trailing slash to folder names
g.nvim_tree_group_empty = 1 -- compact folders that only contain a single folder into one node in the file tree
g.nvim_tree_disable_window_picker = 1
g.nvim_tree_auto_ignore_ft = { "dashboard" }
g.nvim_tree_show_icons = { git = 1, folders = 1, files = 1, folder_arrows = 1 }
g.nvim_tree_icons = {
    default = "",
    symlink = "",
    git = {
        unstaged = "",
        staged = "✓",
        unmerged = "",
        renamed = "➜",
        untracked = "★",
        deleted = "✗",
        ignored = "◌",
    },
    folder = {
        arrow_open = "",
        arrow_closed = "",
        default = "",
        open = "",
        empty = "",
        empty_open = "",
        symlink = "",
        symlink_open = "",
    },
}

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

-- following options are the default
require("nvim-tree").setup({
    auto_close = false,
    diagnostics = { enable = true },
    disable_netrw = false,
    filters = {
        dotfiles = true,
        custom = { ".git", "node_modules", ".cache" },
    },
    hijack_cursor = true,
    hijack_netrw = true,
    ignore_ft_on_setup = {},
    open_on_setup = false,
    open_on_tab = false,
    system_open = {
        cmd = nil,
        args = {},
    },
    tree_follow = true,
    update_cwd = false,
    update_focused_file = {
        enable = true,
        update_cwd = false,
        ignore_list = {},
    },
    view = {
        width = 45,
        height = 30,
        side = "left",
        auto_resize = false,
        mappings = {
            custom_only = false,
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
