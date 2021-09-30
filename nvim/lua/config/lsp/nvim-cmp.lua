local cmp = require("cmp")
local utils = require("utils")

local has_words_before = function()
    if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
        return false
    end
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]
        :sub(col, col)
        :match("%s") == nil
end

local feedkey = function(key, mode)
    vim.api.nvim_feedkeys(utils.t(key), mode, true)
end

cmp.setup({
    documentation = {
        border = "rounded",
        winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
        maxwidth = 120,
        maxheight = math.floor(vim.o.lines * 0.3),
    },
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    mapping = {
        ["<C-d>"] = cmp.mapping.scroll_docs(-5),
        ["<C-f>"] = cmp.mapping.scroll_docs(5),
        ["<C-y>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<C-c>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if vim.fn.pumvisible() == 1 then
                feedkey("<C-n>", "n")
            elseif vim.fn["vsnip#available"]() == 1 then
                feedkey("<Plug>(vsnip-expand-or-jump)", "")
            elseif has_words_before() then
                cmp.complete()
            else
                fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
            end
        end, {
            "i",
            "s",
        }),

        ["<S-Tab>"] = cmp.mapping(function()
            if vim.fn.pumvisible() == 1 then
                feedkey("<C-p>", "n")
            elseif vim.fn["vsnip#jumpable"](-1) == 1 then
                feedkey("<Plug>(vsnip-jump-prev)", "")
            end
        end, {
            "i",
            "s",
        }),
        ["<C-n"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "s" }),
        ["<C-p>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "s" }),
        ["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "s" }),
        ["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "s" }),
    },
    sources = {
        -- NOTE: The order of these are important as it determines priority.
        { name = "calc" },
        { name = "path" },
        { name = "spell" },
        { name = "nvim_lua" },
        { name = "nvim_lsp" },
        { name = "vsnip" },
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
                vsnip = "  [vsnip]",
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
                Snippet = " ﬌ (Snippet)",
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
    -- experimental = {
    --     ghost_text = true,
    -- },
})
