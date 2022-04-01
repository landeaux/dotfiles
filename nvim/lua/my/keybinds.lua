local bind = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Disable some mappings
bind("i", "<C-l>", "<Nop>", {})
bind("v", "<C-l>", "<Nop>", {})
bind("i", "<C-h>", "<Nop>", {})
bind("v", "<C-h>", "<Nop>", {})
bind("i", "<C-j>", "<Nop>", {})
bind("v", "<C-j>", "<Nop>", {})

-- Yank to end of line in visual mode and go back to original cursor position
bind("v", "Y", "<Esc>y$gv", { noremap = true })

-- Make U redo
bind("n", "U", "undo", { noremap = true })

-- Don't leave visual mode after indenting
bind("v", ">", ">gv^", { noremap = true })
bind("v", "<", "<gv^", { noremap = true })

-- Indent with Tab and Shift-Tab
bind("v", "<Tab>", ">", {})
bind("v", "<S-Tab>", "<", {})

-- Use Alt-L to clear the highlighting of :set hlsearch.
bind("n", "<A-l>", ":nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>", opts)

-- Easier escape from insert mode
bind("i", "kk", "<ESC>", opts)
bind("i", "kj", "<ESC>", opts)
bind("i", "jk", "<ESC>", opts)
bind("i", "jj", "<ESC>", opts)

-- Move selected line / block of text in visual mode
bind("x", "J", ":move '>+1<CR>gv-gv", opts)
bind("x", "K", ":move '<-2<CR>gv-gv", opts)

-- Remap for dealing with word wrap
bind("n", "k", "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
bind("n", "j", "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

-- Beginning and end of line in `:` command mode
bind("c", "<C-a>", "<Home>", {})
bind("c", "<C-e>", "<End>", {})
bind("c", "<C-b>", "<Left>", {})
bind("c", "<C-f>", "<Right>", {})

bind("c", "<C-d>", "<C-r>=strftime('%F')<CR>", {})

-- Quickfix navigation
bind("n", "[q", ":cprev<CR>zz", opts)
bind("n", "]q", ":cnext<CR>zz", opts)

-- Loclist navigation
bind("n", "[l", ":lprev<CR>zz", opts)
bind("n", "]l", ":lnext<CR>zz", opts)

-- Buffer navigation
bind("n", "[b", ":bprev<CR>", opts)
bind("n", "]b", ":bnext<CR>", opts)

------------------------------- LEADER MAPPINGS -------------------------------

-- Toggle highlighting
bind("n", "<Leader>th", ":set hlsearch!<CR>", opts)

-- Toggle relativenumber
bind("n", "<Leader>tr", ":set invrelativenumber<CR>", opts)

-- Toggle spelling
bind("n", "<Leader>ts", ":set spell!<CR>", opts)

-- Toggle whitespace chars
bind("n", "<Leader>tw", ":set list!<CR>", opts)

-- Clipboard
bind("", "<Leader>y", '"+y', opts) -- copy any selected text to clipboard
bind("n", "<Leader>a", "<cmd> %+y<CR>", opts) -- copy any selected text to clipboard

-- Quit
bind("n", "<Leader>q", ":quitall<CR>", opts)
bind("n", "<Leader>Q", ":quitall!<CR>", opts)

-- Buffer
bind("n", "<Leader>bd", ":bdelete<CR>", opts)
bind("n", "<Leader>bD", ":bdelete!<CR>", opts)

-- Window
-- Goto window above/below/left/right
bind("n", "<Leader>wh", ":wincmd h<CR>", opts)
bind("n", "<Leader>wj", ":wincmd j<CR>", opts)
bind("n", "<Leader>wk", ":wincmd k<CR>", opts)
bind("n", "<Leader>wl", ":wincmd l<CR>", opts)

-- Resize windows
bind("n", "<Leader>w=", ":wincmd =<CR>", opts)
bind('n', '<C-Up>', ':resize -2<CR>', opts)
bind('n', '<C-Down>', ':resize +2<CR>', opts)
bind('n', '<C-Left>', ':vertical resize -2<CR>', opts)
bind('n', '<C-Right>', ':vertical resize +2<CR>', opts)

-- Rotate windows
bind("n", "<Leader>wr", ":wincmd r<CR>", opts)
bind("n", "<Leader>wR", ":wincmd R<CR>", opts)

-- Move windows
bind("n", "<Leader>wmx", ":wincmd x<CR>", opts)
bind("n", "<Leader>wmh", ":wincmd h<CR>", opts)
bind("n", "<Leader>wmj", ":wincmd j<CR>", opts)
bind("n", "<Leader>wmk", ":wincmd k<CR>", opts)
bind("n", "<Leader>wml", ":wincmd l<CR>", opts)

-- Delete window
bind("n", "<Leader>wq", ":wincmd q<CR>", opts)

-- Split window
bind("n", "<Leader>ws", ":wincmd s<CR>", opts)
bind("n", "<Leader>wv", ":wincmd v<CR>", opts)

-- Keybinds for editing vim config
bind("n", "<Leader>vc", ":edit $MYVIMRC<CR>", opts)
bind("n", "<Leader>vv", ":version<CR>", opts)

-- Search and Replace
-- '<Leader>r' for word, '<Leader>R' for WORD
bind("n", "<Leader>r", [[:%s/\<<C-r><C-w>\>//g<Left><Left>]], { noremap = true })
bind("n", "<Leader>R", [[:%s/\<<C-r><C-a>\>//g<Left><Left>]], { noremap = true })

-- Handling merge conflicts
bind("n", "<Leader>gf", ":diffget //2<CR>", opts) -- choose our change
bind("n", "<Leader>gj", ":diffget //3<CR>", opts) -- choose incoming change

-- Toggle folding
bind("n", "<Space><Space>", "za", opts)
bind("v", "<Space><Space>", "za", opts)

-- Insert Stuff
-- ISO-date: YYYY-MM-DD
bind("n", "<Leader>id", [["=strftime("%F")<CR>P]], opts)
-- ISO-datetime: YYYY-MM-DDTHH:MM:SS
bind("n", "<Leader>iD", [["=strftime("%Y-%m-%dT%H:%M:%S")<CR>P]], opts)

local keys = {
    a = "Yank file to clipboard",
    b = {
        name = "+buffer",
        d = "Delete",
        D = "Force Delete",
    },
    g = {
        name = "+git",
        f = "Choose our change",
        j = "Choose incoming change",
    },
    i = {
        name = "+insert",
        d = "YYYY-MM-DD",
        D = "YYYY-MM-DDTHH:MM:SS",
    },
    q = "Quit all",
    Q = "Quit all without save",
    r = "Replace word under cursor",
    R = "Replace WORD under cursor",
    t = {
        name = "+ui-toggle",
        h = "Highlighting",
        r = "Relative Number",
        s = "Spelling",
        w = "Whitespace",
    },
    v = { name = "+vim", c = "Edit config", v = "Version" },
    w = {
        name = "+windows",
        ["="] = "Balance windows",
        h = "Go to window left",
        j = "Go to window below",
        k = "Go to window above",
        l = "Go to window right",
        r = "Rotate down/right",
        R = "Rotate up/left",
        m = {
            name = "+move",
            x = "Exchange windows",
            h = "Move window left",
            j = "Move window below",
            k = "Move window above",
            l = "Move window right",
        },
        q = "Delete window",
        s = "Split horizontally",
        v = "Split vertically",
    },
    y = "Yank to clipboard",
}

require("whichkey_setup").register_keymap("leader", keys)
