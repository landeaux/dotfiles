local cmp = require("cmp")
local luasnip = require("luasnip")

local select_next_cmp_item = function(fallback)
    if cmp.visible() then
        cmp.select_next_item()
    else
        fallback()
    end
end

local select_prev_cmp_item = function(fallback)
    if cmp.visible() then
        cmp.select_prev_item()
    else
        fallback()
    end
end

local jump_to_next_snippet_node = function(fallback)
    if luasnip.jumpable() then
        luasnip.jump()
    else
        fallback()
    end
end

local jump_to_prev_snippet_node = function(fallback)
    if luasnip.jumpable(-1) then
        luasnip.jump(-1)
    else
        fallback()
    end
end

local select_next_snippet_choice = function(fallback)
    if luasnip.choice_active() then
        luasnip.change_choice(1)
    else
        fallback()
    end
end

local select_prev_snippet_choice = function(fallback)
    if luasnip.choice_active() then
        luasnip.change_choice(-1)
    else
        fallback()
    end
end

cmp.setup({
    -- completion = { autocomplete = false },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        -- General cmp mappings
        ["<C-n>"] = cmp.mapping(select_next_cmp_item, { "i", "s" }),
        ["<C-p>"] = cmp.mapping(select_prev_cmp_item, { "i", "s" }),
        ["<C-d>"] = cmp.mapping.scroll_docs(-5),
        ["<C-f>"] = cmp.mapping.scroll_docs(5),
        ["<C-y>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
        ["<C-e>"] = cmp.mapping.close(),
        ["<C-c>"] = cmp.mapping.abort(),
        -- Snippet mappings
        ["<C-l>"] = cmp.mapping(jump_to_next_snippet_node, { "i", "s" }),
        ["<C-h>"] = cmp.mapping(jump_to_prev_snippet_node, { "i", "s" }),
        ["<C-j>"] = cmp.mapping(select_next_snippet_choice, { "i", "s" }),
        ["<C-k>"] = cmp.mapping(select_prev_snippet_choice, { "i", "s" }),
    }),
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

local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
