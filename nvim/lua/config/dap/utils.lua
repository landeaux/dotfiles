local M = {}
local dap = require("dap")

function M.reload_continue()
    package.loaded["config.dap.configurations"] = nil
    require("config.dap.configurations")
    dap.continue()
end

return M
