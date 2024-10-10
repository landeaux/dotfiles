local cmp = require("cmp")
local luasnip = require("luasnip")

---@diagnostic disable-next-line: missing-fields
cmp.setup({
    -- completion = { autocomplete = false },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    snippet = {
        expand = function(args) luasnip.lsp_expand(args.body) end,
    },
    mapping = cmp.mapping.preset.insert({
        -- General mappings
        ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
        ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
        ["<C-f>"] = cmp.mapping.scroll_docs(5),
        ["<C-b>"] = cmp.mapping.scroll_docs(-5),
        ["<C-y>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
        ["<C-e>"] = cmp.mapping.close(),
        ["<C-c>"] = cmp.mapping.abort(),
        -- Snippet mappings
        ["<C-l>"] = cmp.mapping(function(fallback)
            if luasnip.expand_or_locally_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<C-h>"] = cmp.mapping(function(fallback)
            if luasnip.locally_jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<C-j>"] = cmp.mapping(function(fallback)
            if luasnip.choice_active() then
                luasnip.change_choice(1)
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<C-k>"] = cmp.mapping(function(fallback)
            if luasnip.choice_active() then
                luasnip.change_choice(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    }),
    sources = {
        -- NOTE: The order of these are important as it determines priority.
        { name = "calc" },
        { name = "path" },
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
    },
    ---@diagnostic disable-next-line: missing-fields
    formatting = {
        format = function(entry, vim_item)
            vim_item.menu = ({
                calc = "  [calc]",
                path = "  [path]",
                nvim_lsp = "  [lsp]",
                luasnip = "  [luasnip]",
                buffer = "  [buffer]",
            })[entry.source.name]
            vim_item.kind = ({
                Array = " (Array)",
                Boolean = "󰨙 (Boolean)",
                Class = " (Class)",
                Codeium = "󰘦 (Codeium)",
                Color = " (Color)",
                Control = " (Control)",
                Collapsed = " (Collapsed)",
                Constant = "󰏿 (Constant)",
                Constructor = " (Constructor)",
                Copilot = " (Copilot)",
                Enum = " (Enum)",
                EnumMember = " (EnumMember)",
                Event = " (Event)",
                Field = " (Field)",
                File = " (File)",
                Folder = " (Folder)",
                Function = "󰊕 (Function)",
                Interface = " (Interface)",
                Key = " (Key)",
                Keyword = " (Keyword)",
                Method = "󰊕 (Method)",
                Module = " (Module)",
                Namespace = "󰦮 (Namespace)",
                Null = " (Null)",
                Number = "󰎠 (Number)",
                Object = " (Object)",
                Operator = " (Operator)",
                Package = " (Package)",
                Property = " (Property)",
                Reference = " (Reference)",
                Snippet = " (Snippet)",
                String = " (String)",
                Struct = " (Struct)",
                TabNine = "󰏚 (TabNine)",
                Text = " (Text)",
                TypeParameter = " (TypeParameter)",
                Unit = " (Unit)",
                Value = " (Value)",
                Variable = "󰀫 (Variable)",
            })[vim_item.kind]
            return vim_item
        end,
    },
})

local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
