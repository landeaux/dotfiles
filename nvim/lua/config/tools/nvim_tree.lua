-- Nvim Tree
local g = vim.g
local bind = vim.api.nvim_set_keymap

g.nvim_tree_side = 'left'
g.nvim_tree_width = 40
g.nvim_tree_ignore = {'.git', 'node_modules', '.cache'}
g.nvim_tree_gitignore = 1
g.nvim_tree_auto_open = 1
g.nvim_tree_auto_close = 1
g.nvim_tree_auto_ignore_ft = {'startify', 'dashboard'}
g.nvim_tree_quit_on_open = 0
g.nvim_tree_follow = 1
g.nvim_tree_indent_markers = 1
g.nvim_tree_hide_dotfiles = 1
g.nvim_tree_git_hl = 1
g.nvim_tree_root_folder_modifier = ':~'
g.nvim_tree_tab_open = 1
g.nvim_tree_width_allow_resize = 0
g.nvim_tree_disable_netrw = 1
g.nvim_tree_hijack_netrw = 1
g.nvim_tree_add_trailing = 0
g.nvim_tree_group_empty = 1
g.nvim_tree_lsp_diagnostics = 1
g.nvim_tree_show_icons = {
    git = 1,
    folders = 1,
    files = 1,
}
g.nvim_tree_icons = {
    default = '',
    symlink = '',
    git = {
        unstaged = "✗",
        staged = "✓",
        unmerged = "",
        renamed = "➜",
        untracked = "★"
    },
    folder = {
        default = "",
        open = "",
        empty = "",
        empty_open = "",
        symlink = "",
        symlink_open = "",
    }
}

local get_lua_cb = function(cb_name)
    return string.format(":lua require'nvim-tree'.on_keypress('%s')<CR>", cb_name)
end

-- Mappings

bind('n', '<Leader>tn', ':NvimTreeToggle<CR>', { noremap = true })

g.nvim_tree_bindings = {
    ['<CR>'] = get_lua_cb('edit'),
    ['o'] = get_lua_cb('edit'),
    ['<C-]>'] = get_lua_cb('cd'),
    ['<C-v>'] = get_lua_cb('vsplit'),
    ['<C-x>'] = get_lua_cb('split'),
    ['<C-t>'] = get_lua_cb('tabnew'),
    ['<BS>'] = get_lua_cb('close_node'),
    ['<S-CR>'] = get_lua_cb('close_node'),
    ['<Tab>'] = get_lua_cb('preview'),
    ['I'] = get_lua_cb('toggle_ignored'),
    ['H'] = get_lua_cb('toggle_dotfiles'),
    ['R'] = get_lua_cb('refresh'),
    ['a'] = get_lua_cb('create'),
    ['d'] = get_lua_cb('remove'),
    ['r'] = get_lua_cb('rename'),
    ['<C-r>'] = get_lua_cb('full_rename'),
    ['x'] = get_lua_cb('cut'),
    ['c'] = get_lua_cb('copy'),
    ['p'] = get_lua_cb('paste'),
    ['[c'] = get_lua_cb('prev_git_item'),
    [']c'] = get_lua_cb('next_git_item'),
    ['-'] = get_lua_cb('dir_up'),
    ['q'] = get_lua_cb('close')
}

require('whichkey_setup').register_keymap('leader', {
    t = {
        name = '+ui-toggle',
        n = 'NvimTree',
    }
})