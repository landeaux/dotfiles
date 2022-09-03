local wk = require("which-key")
local keymap_g = { name = "+goto", l = { name = "+ts-selection", i = "Initialize selection" } }

wk.register(keymap_g, { prefix = "g" })

local keymap_leader = {
    [">"] = "TS: Swap next parameter",
    ["<"] = "TS: Swap previous parameter",
    l = {
        name = "+lsp",
        p = {
            name = "+peek_definition_code",
            f = "Peek funtion definition",
            c = "Peek class definition",
        },
    },
}

wk.register(keymap_leader, { prefix = "<leader>" })
