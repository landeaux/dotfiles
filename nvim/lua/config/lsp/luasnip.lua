require("luasnip").config.setup({ store_selection_keys = "<CR>" })

require("luasnip/loaders/from_vscode").lazy_load({
    paths = { "~/.local/share/nvim/site/pack/packer/start/friendly-snippets" },
})

require("luasnip/loaders/from_vscode").load({ paths = { "~/.dotfiles/snippets" } })
