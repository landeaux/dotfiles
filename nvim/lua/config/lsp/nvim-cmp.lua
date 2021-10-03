local luasnip = require("luasnip")
local cmp = require("cmp")
-- local utils = require("utils")

-- local has_words_before = function()
--     if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
--         return false
--     end
--     local line, col = unpack(vim.api.nvim_win_get_cursor(0))
--     return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]
--         :sub(col, col)
--         :match("%s") == nil
-- end

-- local feedkey = function(key, mode)
--     vim.api.nvim_feedkeys(utils.t(key), mode, true)
-- end

cmp.setup({
    documentation = {
        border = "rounded",
        winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
        maxwidth = 120,
        maxheight = math.floor(vim.o.lines * 0.3),
    },
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    mapping = {
        ["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "s" }),
        ["<C-n"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "s" }),
        ["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "s" }),
        ["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "s" }),
        ["<C-d>"] = cmp.mapping.scroll_docs(-5),
        ["<C-f>"] = cmp.mapping.scroll_docs(5),
        ["<C-y>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<C-c>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        }),
        ["<Tab>"] = function(fallback)
            if vim.fn.pumvisible() == 1 then
                vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-n>", true, true, true), "n")
            elseif luasnip.expand_or_jumpable() then
                vim.fn.feedkeys(
                    vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true),
                    ""
                )
            else
                fallback()
            end
        end,
        ["<S-Tab>"] = function(fallback)
            if vim.fn.pumvisible() == 1 then
                vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-p>", true, true, true), "n")
            elseif luasnip.jumpable(-1) then
                vim.fn.feedkeys(
                    vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true),
                    ""
                )
            else
                fallback()
            end
        end,
    },
    sources = {
        -- NOTE: The order of these are important as it determines priority.
        { name = "calc" },
        { name = "path" },
        { name = "spell" },
        { name = "nvim_lua" },
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
    },
    formatting = {
        format = function(entry, vim_item)
            vim_item.menu = ({
                calc = "  [calc]",
                path = "  [path]",
                spell = "  [spell]",
                nvim_lua = "  [lua]",
                nvim_lsp = "  [lsp]",
                luasnip = "  [luasnip]",
                buffer = "  [buffer]",
            })[entry.source.name]
            vim_item.kind = ({
                Class = "  (Class)",
                Color = "  (Color)",
                Constant = "  (Constant)",
                Constructor = "  (Constructor)",
                Enum = "  (Enum)",
                EnumMember = "  (EnumMember)",
                Event = "  (Event)",
                Field = "  (Field)",
                File = "  (File)",
                Folder = "  (Folder)",
                Function = "  (Function)",
                Interface = " ﰮ (Interface)",
                Keyword = "  (Keyword)",
                Method = "  (Method)",
                Module = "  (Module)",
                Operator = "  (Operator)",
                Property = " 襁 (Property)",
                Reference = "  (Reference)",
                Snippet = "  (Snippet)",
                Struct = "  (Struct)",
                Text = "  (Text)",
                TypeParameter = "  (TypeParameter)",
                Unit = "  (Unit)",
                Value = "  (Value)",
                Variable = "[] (Variable)",
            })[vim_item.kind]
            return vim_item
        end,
    },
})
