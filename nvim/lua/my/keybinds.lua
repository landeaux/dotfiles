local map = vim.keymap.set
local opts = { silent = true }

require("my.plugins.nvim-colorizer.mappings")
require("my.plugins.bufferline.mappings")
require("my.plugins.indent-blankline.mappings")

-- Disable some mappings
map({ "i", "v" }, "<C-l>", "")
map({ "i", "v" }, "<C-h>", "")
map({ "i", "v" }, "<C-j>", "")

-- Make U redo
map("n", "U", "undo")

-- Don't leave visual mode after indenting
map("v", ">", ">gv^")
map("v", "<", "<gv^")

-- Indent with Tab and Shift-Tab
map("v", "<Tab>", ">gv^")
map("v", "<S-Tab>", "<gv^")

-- Easier escape from insert mode
map("i", "kk", "<ESC>", opts)
map("i", "kj", "<ESC>", opts)
map("i", "jk", "<ESC>", opts)
map("i", "jj", "<ESC>", opts)

-- Move selected line / block of text in visual mode
map("x", "J", ":move '>+1<CR>gv-gv", opts)
map("x", "K", ":move '<-2<CR>gv-gv", opts)

-- Remap for dealing with word wrap
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Beginning and end of line in `:` command mode
map("c", "<C-a>", "<Home>")
map("c", "<C-e>", "<End>")
map("c", "<C-b>", "<Left>")
map("c", "<C-f>", "<Right>")

-- Quickfix navigation
map("n", "[q", ":cprev<CR>zz", opts)
map("n", "]q", ":cnext<CR>zz", opts)

-- Loclist navigation
map("n", "[l", ":lprev<CR>zz", opts)
map("n", "]l", ":lnext<CR>zz", opts)

-- Buffer navigation
map("n", "[b", ":bprev<CR>", opts)
map("n", "]b", ":bnext<CR>", opts)

------------------------------- LEADER MAPPINGS -------------------------------

-- Toggle highlighting
map("n", "<Leader>th", ":set hlsearch!<CR>", opts)

-- Toggle relativenumber
map("n", "<Leader>tr", ":set invrelativenumber<CR>", opts)

-- Toggle spelling
map("n", "<Leader>ts", ":set spell!<CR>", opts)

-- Toggle whitespace chars
map("n", "<Leader>tw", ":set list!<CR>", opts)

-- Toggle color column
map("n", "<Leader>tk", function()
    local cc = '"'
        .. tostring(vim.g.soft_column_limit)
        .. ',".join(range('
        .. tostring(vim.g.hard_column_limit)
        .. ',999),",")'
    vim.cmd(':execute "set cc=" . (&cc == "" ?' .. cc .. ': "")')
end, opts)

-- Clipboard
map("", "<Leader>y", '"+y', opts) -- copy any selected text to clipboard
map("n", "<Leader>a", "<cmd> %+y<CR>", opts) -- copy any selected text to clipboard

-- Quit
map("n", "<Leader>q", ":quitall<CR>", opts)
map("n", "<Leader>Q", ":quitall!<CR>", opts)

-- Buffer
map("n", "<Leader>bd", ":bdelete<CR>", opts)
map("n", "<Leader>bD", ":bdelete!<CR>", opts)

-- Resize windows
map("n", "<C-Up>", ":resize -2<CR>", opts)
map("n", "<C-Down>", ":resize +2<CR>", opts)
map("n", "<C-Left>", ":vertical resize -2<CR>", opts)
map("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Keybinds for editing vim config
map("n", "<Leader>vc", ":edit $MYVIMRC<CR>", opts)
map("n", "<Leader>vv", ":version<CR>", opts)

-- Search and Replace
-- '<Leader>r' for word, '<Leader>R' for WORD
map("n", "<Leader>r", [["zyiw:%s/\<<C-r>z\>/<C-r>z/g<Left><Left>]])
map("n", "<Leader>R", [["zyiW:%s/\<<C-r>z\>/<C-r>z/g<Left><Left>]])

-- Handling merge conflicts
map("n", "<Leader>gf", ":diffget //2<CR>", opts) -- choose our change
map("n", "<Leader>gj", ":diffget //3<CR>", opts) -- choose incoming change

-- Toggle folding
map({ "n", "v" }, "<Leader><Space>", "za", opts)

-- Insert ISO-date: YYYY-MM-DD
map("n", "<Leader>id", [["=strftime("%F")<CR>P]], opts)
map("c", "<C-d>", "<C-r>=strftime('%F')<CR>")

-- Insert ISO-datetime: YYYY-MM-DDTHH:MM:SS
map("n", "<Leader>iD", [["=strftime("%Y-%m-%dT%H:%M:%S")<CR>P]], opts)

-- Extended text-objects
local chars = { "_", ".", ":", ",", ";", "|", "/", "*", "%", "`", "-", "~" }
for _, char in ipairs(chars) do
    for _, mode in ipairs({ "x", "o" }) do
        vim.keymap.set(
            mode,
            "i" .. char,
            string.format(":<C-u>silent! normal! f%sF%slvt%s<CR>", char, char, char),
            opts
        )
        vim.keymap.set(
            mode,
            "a" .. char,
            string.format(":<C-u>silent! normal! f%sF%svf%s<CR>", char, char, char),
            opts
        )
    end
end

local ok, _ = pcall(require, "which-key")
if ok then
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

    require("which-key").register(keys, { prefix = "<leader>" })
end
