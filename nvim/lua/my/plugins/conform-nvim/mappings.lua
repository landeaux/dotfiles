local conform = require("conform")
local map = require("my.utils").map_factory({ silent = true })

map({ "n", "v" }, "<Leader>lf", function()
    conform.format({ async = true, lsp_fallback = true })
end, { desc = "Format" })
