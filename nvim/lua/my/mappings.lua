local map = vim.keymap.set

require("my.plugins.nvim-colorizer.mappings")
require("my.plugins.bufferline.mappings")
require("my.plugins.indent-blankline.mappings")
require("my.plugins.fugitive.mappings")
require("my.plugins.gv.mappings")
require("my.plugins.undotree.mappings")
require("my.plugins.fterm.mappings")
require("my.plugins.kommentary.mappings")
require("my.plugins.tree-sitter.mappings")
require("my.plugins.markdown-preview.mappings")
require("my.plugins.vim-pydocstring.mappings")
require("my.plugins.neo-tree.mappings")
require("my.plugins.telescope-nvim.mappings")
require("my.plugins.nvim-dap.mappings")
require("my.plugins.nvim-dap-python.mappings")

-- Disable some mappings
map({ "i", "v" }, "<C-l>", "")
map({ "i", "v" }, "<C-h>", "")
map({ "i", "v" }, "<C-j>", "")

-- Indentation in visual mode
map("v", ">", ">gv^", { silent = true, desc = "Indent right without leaving visual mode" })
map("v", "<", "<gv^", { silent = true, desc = "Indent left without leaving visual mode" })
map("v", "<Tab>", ">gv^", { silent = true, desc = "Indent right without leaving visual mode" })
map("v", "<S-Tab>", "<gv^", { silent = true, desc = "Indent left without leaving visual mode" })

-- Easy escape from insert mode
map("i", "kk", "<ESC>", { silent = true, desc = "Escape from insert mode" })
map("i", "kj", "<ESC>", { silent = true, desc = "Escape from insert mode" })
map("i", "jk", "<ESC>", { silent = true, desc = "Escape from insert mode" })
map("i", "jj", "<ESC>", { silent = true, desc = "Escape from insert mode" })

map(
    "x",
    "J",
    ":move '>+1<CR>gv-gv",
    { silent = true, desc = "Move selected line/block of text up one line" }
)
map(
    "x",
    "K",
    ":move '<-2<CR>gv-gv",
    { silent = true, desc = "Move selected line/block of text down one line" }
)

-- Remap for dealing with word wrap
map(
    "n",
    "k",
    "v:count == 0 ? 'gk' : 'k'",
    { expr = true, silent = true, desc = "Move up one line through wrapped text" }
)
map(
    "n",
    "j",
    "v:count == 0 ? 'gj' : 'j'",
    { expr = true, silent = true, desc = "Move down one line through wrapped text" }
)

-- Make command mode behave like terminal
map("c", "<C-a>", "<Home>", { desc = "Go to beginning of command line" })
map("c", "<C-e>", "<End>", { desc = "Go to end of command line" })
map("c", "<C-b>", "<Left>", { desc = "Go back one character" })
map("c", "<C-f>", "<Right>", { desc = "Go forward one character" })

-- Quickfix navigation
map("n", "[q", ":cprev<CR>zz", { silent = true, desc = "Go to previous quickfix item" })
map("n", "]q", ":cnext<CR>zz", { silent = true, desc = "Go to next quickfix item" })

-- Loclist navigation
map("n", "[l", ":lprev<CR>zz", { silent = true, desc = "Go to previous location list item" })
map("n", "]l", ":lnext<CR>zz", { silent = true, desc = "Go to next location list item" })

-- Buffer navigation
map("n", "[b", ":bprev<CR>", { silent = true, desc = "Go to previous buffer" })
map("n", "]b", ":bnext<CR>", { silent = true, desc = "Go to next buffer" })

------------------------------- LEADER MAPPINGS -------------------------------

map(
    { "n", "v" },
    "<Leader>th",
    ":set hlsearch!<CR>",
    { silent = true, desc = "Toggle highlighting" }
)
map(
    { "n", "v" },
    "<Leader>tr",
    ":set invrelativenumber<CR>",
    { silent = true, desc = "Toggle relative number" }
)
map({ "n", "v" }, "<Leader>ts", ":set spell!<CR>", { silent = true, desc = "Toggle spelling" })
map(
    { "n", "v" },
    "<Leader>tw",
    ":set list!<CR>",
    { silent = true, desc = "Toggle whitespace chars" }
)
map({ "n", "v" }, "<Leader>tk", function()
    local cc = '"'
        .. tostring(vim.g.soft_column_limit)
        .. ',".join(range('
        .. tostring(vim.g.hard_column_limit)
        .. ',999),",")'
    vim.cmd(':execute "set cc=" . (&cc == "" ?' .. cc .. ': "")')
end, { silent = true, desc = "Toggle color column" })
map({ "n", "v" }, "<Leader>tf", "za", { silent = true, desc = "Toggle folding" })

-- Clipboard
map("n", "<Leader>a", "<cmd> %+y<CR>", { silent = true, desc = "Copy file contents to clipboard" })

-- Quit
map("n", "<Leader>q", ":quitall<CR>", { silent = true, desc = "Quit neovim" })
map("n", "<Leader>Q", ":quitall!<CR>", { silent = true, desc = "Force-quit neovim" })

-- Buffer
map("n", "<Leader>bd", ":bdelete<CR>", { silent = true, desc = "Delete buffer" })
map("n", "<Leader>bD", ":bdelete!<CR>", { silent = true, desc = "Force-delete buffer" })

-- Resize windows
map("n", "<A-Up>", ":resize -2<CR>", { silent = true, desc = "Resize window upward" })
map("n", "<A-Down>", ":resize +2<CR>", { silent = true, desc = "Resize window downward" })
map("n", "<A-Left>", ":vertical resize -2<CR>", { silent = true, desc = "Resize window left" })
map("n", "<A-Right>", ":vertical resize +2<CR>", { silent = true, desc = "Resize window right" })

-- Search and Replace
map(
    "n",
    "<Leader>r",
    [["zyiw:%s/\<<C-r>z\>/<C-r>z/g<Left><Left>]],
    { silent = true, desc = "Replace word under cursor" }
)
map(
    "n",
    "<Leader>R",
    [["zyiW:%s/\<<C-r>z\>/<C-r>z/g<Left><Left>]],
    { silent = true, desc = "Replace WORD under cursor" }
)

-- Handling merge conflicts
map("n", "<Leader>gf", ":diffget //2<CR>", { silent = true, desc = "Choose our change" })
map("n", "<Leader>gj", ":diffget //3<CR>", { silent = true, desc = "Choose incoming change" })

-- Insert ISO-date
map(
    "n",
    "<Leader>id",
    [["=strftime("%F")<CR>P]],
    { silent = true, desc = "Insert ISO-date: YYYY-MM-DD" }
)
map("c", "<C-d>", "<C-r>=strftime('%F')<CR>", { desc = "Insert ISO-date: YYYY-MM-DD" })
map(
    "n",
    "<Leader>iD",
    [["=strftime("%Y-%m-%dT%H:%M:%S")<CR>P]],
    { silent = true, desc = "Insert ISO-date: YYYY-MM-DDTHH:MM:SS" }
)

-- Extended text-objects
local chars = { "_", ".", ":", ",", ";", "|", "/", "*", "%", "`", "-", "~" }
for _, char in ipairs(chars) do
    for _, mode in ipairs({ "x", "o" }) do
        vim.keymap.set(
            mode,
            "i" .. char,
            string.format(":<C-u>silent! normal! f%sF%slvt%s<CR>", char, char, char),
            { silent = true, desc = "inner " .. char .. "text" .. char }
        )
        vim.keymap.set(
            mode,
            "a" .. char,
            string.format(":<C-u>silent! normal! f%sF%svf%s<CR>", char, char, char),
            { silent = true, desc = "surrounding " .. char .. "text" .. char }
        )
    end
end

map("n", "<Leader>ek", function()
    vim.diagnostic.open_float(0, { scope = "cursor" })
end, { desc = "Show cursor diagnostics" })
map("n", "<Leader>el", vim.diagnostic.open_float, { desc = "Show line diagnostics" })
map("n", "<Leader>eq", vim.diagnostic.setloclist, { desc = "Add diagnostics to location list" })
map("n", "[e", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
map("n", "]e", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })

local ok, wk = pcall(require, "which-key")
if ok then
    wk.register({
        b = { name = "+buffer" },
        e = { name = "+diagnostics" },
        g = { name = "+git" },
        i = { name = "+insert" },
        t = { name = "+ui-toggle" },
    }, { prefix = "<leader>" })
end
