local M = {}
local dap = require("dap")

-- Reload DAP configurations before starting a debug session
function M.reload_continue()
    -- invalidate the cache
    package.loaded["plugins.config.dap.configurations"] = nil
    -- reload the configurations
    require("plugins.config.dap.configurations")
    -- start the debugger
    dap.continue()
end

return M
