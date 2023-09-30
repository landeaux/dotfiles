local map = require("my.utils").map_factory({ silent = true })

-- Disable some mappings
map({ "i", "v" }, "<C-l>", "")
map({ "i", "v" }, "<C-h>", "")
map({ "i", "v" }, "<C-j>", "")

-- Indentation in visual mode
map("v", ">", ">gv^", { desc = "Indent right without leaving visual mode" })
map("v", "<", "<gv^", { desc = "Indent left without leaving visual mode" })
map("v", "<Tab>", ">gv^", { desc = "Indent right without leaving visual mode" })
map("v", "<S-Tab>", "<gv^", { desc = "Indent left without leaving visual mode" })

map("x", "J", ":move '>+1<CR>gv=gv", { desc = "Move selected line/block of text up one line" })
map("x", "K", ":move '<-2<CR>gv=gv", { desc = "Move selected line/block of text down one line" })

-- Remap for dealing with word wrap
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, desc = "Move up one line through wrapped text" })
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, desc = "Move down one line through wrapped text" })

-- Make command mode behave like terminal
map("c", "<C-a>", "<Home>", { silent = false, desc = "Go to beginning of command line" })
map("c", "<C-e>", "<End>", { silent = false, desc = "Go to end of command line" })
map("c", "<C-b>", "<Left>", { silent = false, desc = "Go back one character" })
map("c", "<C-f>", "<Right>", { silent = false, desc = "Go forward one character" })

-- Quickfix navigation
map("n", "[q", ":cprev<CR>zz", { desc = "Go to previous quickfix item" })
map("n", "]q", ":cnext<CR>zz", { desc = "Go to next quickfix item" })

-- Loclist navigation
map("n", "[l", ":lprev<CR>zz", { desc = "Go to previous location list item" })
map("n", "]l", ":lnext<CR>zz", { desc = "Go to next location list item" })

-- Buffer navigation
map("n", "[b", ":bprev<CR>", { desc = "Go to previous buffer" })
map("n", "]b", ":bnext<CR>", { desc = "Go to next buffer" })

-- Better pasting in insert mode
map("i", "<C-r>", "<C-r><C-o>", { desc = "Paste from register and preserve indentation" })

------------------------------- LEADER MAPPINGS -------------------------------

map({ "n", "v" }, "<Leader>th", ":set hlsearch!<CR>", { desc = "Toggle highlighting" })
map({ "n", "v" }, "<Leader>tr", ":set invrelativenumber<CR>", { desc = "Toggle relative number" })
map({ "n", "v" }, "<Leader>ts", ":set spell! spell?<CR>", { desc = "Toggle spelling" })
map({ "n", "v" }, "<Leader>tw", ":set list!<CR>", { desc = "Toggle whitespace chars" })
map({ "n", "v" }, "<Leader>tk", function()
    local cc = '"'
        .. tostring(vim.g.soft_column_limit)
        .. ',".join(range('
        .. tostring(vim.g.hard_column_limit)
        .. ',999),",")'
    vim.cmd(':execute "set cc=" . (&cc == "" ?' .. cc .. ': "")')
end, {
    desc = "Toggle color column",
})

-- Clipboard
map("n", "<Leader>a", "<cmd> %+y<CR>", { desc = "Copy file contents to clipboard" })

-- Quit
map("n", "<Leader>q", ":quitall<CR>", { desc = "Quit neovim" })
map("n", "<Leader>Q", ":quitall!<CR>", { desc = "Force-quit neovim" })

-- Buffer
map("n", "<Leader>bd", ":bdelete<CR>", { desc = "Delete buffer" })
map("n", "<Leader>bD", ":bdelete!<CR>", { desc = "Force-delete buffer" })

-- Resize windows
map("n", "<A-Up>", ":resize -2<CR>", { desc = "Resize window upward" })
map("n", "<A-Down>", ":resize +2<CR>", { desc = "Resize window downward" })
map("n", "<A-Left>", ":vertical resize -2<CR>", { desc = "Resize window left" })
map("n", "<A-Right>", ":vertical resize +2<CR>", { desc = "Resize window right" })

-- Search and Replace
map(
    "n",
    "<Leader>r",
    [["zyiw:%s/\<<C-r>z\>/<C-r>z/g<Left><Left>]],
    { silent = false, desc = "Replace word under cursor" }
)
map(
    "n",
    "<Leader>R",
    [["zyiW:%s/\<<C-r>z\>/<C-r>z/g<Left><Left>]],
    { silent = false, desc = "Replace WORD under cursor" }
)

-- Handling merge conflicts
map("n", "<Leader>gf", ":diffget //2<CR>", { desc = "Choose our change" })
map("n", "<Leader>gj", ":diffget //3<CR>", { desc = "Choose incoming change" })

-- Insert ISO-date
map("n", "<Leader>id", [["=strftime("%F")<CR>P]], { desc = "Insert ISO-date: YYYY-MM-DD" })
map("n", "<Leader>iD", [["=strftime("%Y-%m-%dT%H:%M:%S")<CR>P]], { desc = "Insert ISO-date: YYYY-MM-DDTHH:MM:SS" })

-- Insert current filename without extension
map("n", "<Leader>if", [["=expand('%:t:r')<CR>P]], { desc = "Insert filename without extension" })

-- Extended text-objects
local chars = { "_", ".", ":", ",", ";", "|", "/", "*", "%", "`", "-", "~" }
for _, char in ipairs(chars) do
    for _, mode in ipairs({ "x", "o" }) do
        vim.keymap.set(
            mode,
            "i" .. char,
            string.format(":<C-u>silent! normal! f%sF%slvt%s<CR>", char, char, char),
            { desc = "inner " .. char .. "text" .. char }
        )
        vim.keymap.set(
            mode,
            "a" .. char,
            string.format(":<C-u>silent! normal! f%sF%svf%s<CR>", char, char, char),
            { desc = "surrounding " .. char .. "text" .. char }
        )
    end
end

-- Diagnostics
map("n", "<Leader>ek", function()
    vim.diagnostic.open_float({ scope = "cursor" })
end, {
    desc = "Show cursor diagnostics",
})
map("n", "<Leader>el", vim.diagnostic.open_float, { desc = "Show line diagnostics" })
map("n", "<Leader>eq", vim.diagnostic.setloclist, { desc = "Add diagnostics to location list" })
map("n", "[e", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
map("n", "]e", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })

-- Add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")
