require("luasnip").config.setup({ history = false, store_selection_keys = "<CR>" })

require("luasnip/loaders/from_vscode").lazy_load({
    paths = { "~/.local/share/nvim/site/pack/packer/start/friendly-snippets" },
})

require("luasnip/loaders/from_vscode").load({ paths = { "~/.dotfiles/snippets" } })
