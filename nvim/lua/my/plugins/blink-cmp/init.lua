require("blink.compat").setup({})

---@module 'blink.cmp'
---@type blink.cmp.Config
local opts = {
    keymap = {
        preset = "default",
    },

    appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = "mono",
    },

    completion = {
        documentation = {
            -- (Default) Only show the documentation popup when manually triggered
            auto_show = true,
        },
        menu = {
            -- nvim-cmp style menu
            draw = {
                columns = {
                    { "label", "label_description", gap = 1 },
                    { "kind_icon", "kind", gap = 1 },
                },
            },
        },
    },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
        default = { "lazydev", "lsp", "path", "snippets", "buffer", "calc" },
        providers = {
            calc = {
                -- IMPORTANT: use the same name as you would for nvim-cmp
                name = "calc",
                module = "blink.compat.source",
                score_offset = -3,
            },
            lazydev = {
                name = "LazyDev",
                module = "lazydev.integrations.blink",
                -- make lazydev completions top priority (see `:h blink.cmp`)
                score_offset = 100,
            },
        },
    },

    snippets = {
        preset = "luasnip",
    },

    -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
    -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
    -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
    --
    -- See the fuzzy documentation for more information
    fuzzy = { implementation = "prefer_rust_with_warning" },

    signature = { enabled = false },
}

require("blink.cmp").setup(opts)
