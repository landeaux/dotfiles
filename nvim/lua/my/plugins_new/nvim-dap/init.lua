return {
    "mfussenegger/nvim-dap",
    init = function()
        require("my.plugins_new.nvim-dap.mappings")
    end,
    config = function()
        require("my.plugins_new.nvim-dap.config")
    end,
}
