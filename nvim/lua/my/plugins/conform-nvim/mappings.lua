local conform = require("conform")
local map = require("my.utils").map_factory({ silent = true })

map("n", "<Leader>lf", function()
    conform.format({ async = true, lsp_fallback = true })
end, { desc = "Format" })
