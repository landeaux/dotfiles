require("neorg").setup({
    load = {
        ["core.defaults"] = {}, -- Loads default behaviour
        ["core.concealer"] = {}, -- Adds pretty icons to your documents
        ["core.dirman"] = { -- Manages Neorg workspaces
            config = {
                workspaces = {
                    notes = "~/Notes",
                },
                default_workspace = "notes",
            },
        },
        ["core.completion"] = {
            config = {
                engine = "nvim-cmp",
            },
        },
        ["core.keybinds"] = {
            config = {
                hook = function(keybinds)
                    keybinds.remap_key("norg", "n", "<C-Space>", "<LocalLeader><Space>")
                end,
            },
        },
    },
})
