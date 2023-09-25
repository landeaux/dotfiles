local cmp = require("cmp")
local luasnip = require("luasnip")

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local select_next_cmp_item = function(fallback)
    if cmp.visible() then
        cmp.select_next_item()
    else
        fallback()
    end
end

local select_prev_cmp_item = function(fallback)
    if luasnip.choice_active() then
        luasnip.change_choice(-1)
    elseif cmp.visible() then
        cmp.select_prev_item()
    else
        fallback()
    end
end

local expand_jump_or_select_next_cmp_item = function(fallback)
    if luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
    elseif cmp.visible() then
        cmp.select_next_item()
    elseif has_words_before() then
        cmp.complete()
    else
        fallback()
    end
end

local jump_or_select_prev_cmp_item = function(fallback)
    if luasnip.jumpable(-1) then
        luasnip.jump(-1)
    elseif cmp.visible() then
        cmp.select_prev_item()
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

---@diagnostic disable-next-line: missing-fields
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
        -- General mappings
        ["<C-n>"] = cmp.mapping(select_next_cmp_item, { "i", "s" }),
        ["<C-p>"] = cmp.mapping(select_prev_cmp_item, { "i", "s" }),
        ["<C-f>"] = cmp.mapping.scroll_docs(5),
        ["<C-b>"] = cmp.mapping.scroll_docs(-5),
        ["<C-y>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
        ["<C-e>"] = cmp.mapping.close(),
        ["<C-c>"] = cmp.mapping.abort(),
        -- Snippet mappings
        ["<C-l>"] = cmp.mapping(expand_jump_or_select_next_cmp_item, { "i", "s" }),
        ["<C-h>"] = cmp.mapping(jump_or_select_prev_cmp_item, { "i", "s" }),
        ["<C-j>"] = cmp.mapping(select_next_snippet_choice, { "i", "s" }),
        ["<C-k>"] = cmp.mapping(select_prev_snippet_choice, { "i", "s" }),
    }),
    sources = {
        -- NOTE: The order of these are important as it determines priority.
        { name = "neorg" },
        { name = "calc" },
        { name = "path" },
        { name = "nvim_lua" },
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
                nvim_lua = "  [lua]",
                nvim_lsp = "  [lsp]",
                luasnip = "  [luasnip]",
                buffer = "  [buffer]",
            })[entry.source.name]
            vim_item.kind = ({
                Array = " (Array)",
                Boolean = " (Boolean)",
                Class = " (Class)",
                Color = " (Color)",
                Constant = " (Constant)",
                Constructor = " (Constructor)",
                Copilot = " (Copilot)",
                Enum = " (Enum)",
                EnumMember = " (EnumMember)",
                Event = " (Event)",
                Field = " (Field)",
                File = " (File)",
                Folder = " (Folder)",
                Function = "󰊕 (Function)",
                Interface = " (Interface)",
                Key = " (Key)",
                Keyword = " (Keyword)",
                Method = " (Method)",
                Module = " (Module)",
                Namespace = " (Namespace)",
                Null = " (Null)",
                Number = " (Number)",
                Object = " (Object)",
                Operator = " (Operator)",
                Package = " (Package)",
                Property = " (Property)",
                Reference = " (Reference)",
                Snippet = " (Snippet)",
                String = " (String)",
                Struct = " (Struct)",
                Text = " (Text)",
                TypeParameter = " (Type Parameter)",
                Unit = " (Unit)",
                Value = "󰎠 (Value)",
                Variable = " (Variable)",
            })[vim_item.kind]
            return vim_item
        end,
    },
})

local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

