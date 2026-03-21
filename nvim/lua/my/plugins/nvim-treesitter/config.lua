-- Parser installation
local ts = require("nvim-treesitter")
local wanted = {
    "bash",
    "comment",
    "css",
    "dockerfile",
    "gitignore",
    "html",
    "javascript",
    "jsdoc",
    "json",
    "lua",
    "make",
    "markdown",
    "markdown_inline",
    "php",
    "python",
    "query",
    "regex",
    "rst",
    "scss",
    "sql",
    "toml",
    "tsx",
    "typescript",
    "vim",
    "vue",
    "yaml",
}
local installed = ts.get_installed()
local missing = vim.tbl_filter(function(p) return not vim.list_contains(installed, p) end, wanted)
if #missing > 0 then
    ts.install(missing):wait(300000)
end

-- Enable treesitter features per buffer
local function enable_treesitter(bufnr)
    if not vim.api.nvim_buf_is_valid(bufnr) then
        return
    end
    local ok = pcall(vim.treesitter.start, bufnr)
    if ok then
        vim.bo[bufnr].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        for _, winid in ipairs(vim.fn.win_findbuf(bufnr)) do
            vim.wo[winid].foldexpr = "v:lua.vim.treesitter.foldexpr()"
            vim.wo[winid].foldmethod = "expr"
        end
    end
end

-- Auto-install + feature enablement on FileType
vim.api.nvim_create_autocmd("FileType", {
    callback = function(args)
        local bufnr = args.buf
        local lang = vim.treesitter.language.get_lang(args.match) or args.match

        if not vim.list_contains(ts.get_installed(), lang) then
            local available = ts.get_available()
            if vim.list_contains(available, lang) then
                ts.install({ lang }):await(function(err)
                    if not err then
                        vim.schedule(function() enable_treesitter(bufnr) end)
                    end
                end)
                return
            end
        end

        enable_treesitter(bufnr)
    end,
})

-- Textobjects
require("nvim-treesitter-textobjects").setup({
    select = { lookahead = true },
})

local select_to = function(capture)
    return function() require("nvim-treesitter-textobjects.select").select_textobject(capture, "textobjects") end
end
vim.keymap.set({ "x", "o" }, "af", select_to("@function.outer"))
vim.keymap.set({ "x", "o" }, "if", select_to("@function.inner"))
vim.keymap.set({ "x", "o" }, "ac", select_to("@class.outer"))
vim.keymap.set({ "x", "o" }, "ic", select_to("@class.inner"))
vim.keymap.set({ "x", "o" }, "al", select_to("@loop.outer"))
vim.keymap.set({ "x", "o" }, "il", select_to("@loop.inner"))
vim.keymap.set({ "x", "o" }, "ai", select_to("@conditional.outer"))
vim.keymap.set({ "x", "o" }, "ii", select_to("@conditional.inner"))
vim.keymap.set({ "x", "o" }, "a/", select_to("@comment.outer"))

vim.keymap.set(
    "n",
    "<leader>>",
    function() require("nvim-treesitter-textobjects.swap").swap_next("@parameter.inner") end
)
vim.keymap.set(
    "n",
    "<leader><",
    function() require("nvim-treesitter-textobjects.swap").swap_previous("@parameter.inner") end
)

local move_to = function(fn, capture)
    return function() require("nvim-treesitter-textobjects.move")[fn](capture, "textobjects") end
end
vim.keymap.set({ "n", "x", "o" }, "]m", move_to("goto_next_start", "@function.outer"))
vim.keymap.set({ "n", "x", "o" }, "]M", move_to("goto_next_end", "@function.outer"))
vim.keymap.set({ "n", "x", "o" }, "]]", move_to("goto_next_start", "@class.outer"))
vim.keymap.set({ "n", "x", "o" }, "][", move_to("goto_next_end", "@class.outer"))
vim.keymap.set({ "n", "x", "o" }, "[m", move_to("goto_previous_start", "@function.outer"))
vim.keymap.set({ "n", "x", "o" }, "[M", move_to("goto_previous_end", "@function.outer"))
vim.keymap.set({ "n", "x", "o" }, "[[", move_to("goto_previous_start", "@class.outer"))
vim.keymap.set({ "n", "x", "o" }, "[]", move_to("goto_previous_end", "@class.outer"))

-- Custom Smarty parser
vim.api.nvim_create_autocmd("User", {
    pattern = "TSUpdate",
    callback = function()
        require("nvim-treesitter.parsers").smarty = {
            install_info = {
                url = "https://github.com/Kibadda/tree-sitter-smarty",
                files = { "src/parser.c" },
                branch = "main",
            },
        }
    end,
})
