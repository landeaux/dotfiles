-- Setup nvim-cmp.
local cmp = require("cmp")

cmp.setup({
    documentation = {
        border = { "", "", "", " ", "", "", "", " " }, -- the border option is the same as `|help nvim_open_win|`
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
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<S-Tab>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "s" }),
        ["<Tab>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "s" }),
        ["<C-n"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "s" }),
        ["<C-p>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "s" }),
    },
    sources = {
        { name = "buffer" },
        { name = "calc" },
        { name = "nvim_lsp" },
        { name = "path" },
        { name = "spell" },
        { name = "vsnip" },
    },
    formatting = {
        format = function(entry, vim_item)
            vim_item.menu = ({
                buffer = "  [buffer]",
                calc = "  [calc]",
                nvim_lsp = "  [lsp]",
                path = "  [path]",
                spell = "  [spell]",
                vsnip = "  [vsnip]",
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
    experimental = {
        ghost_text = true,
    },
})
