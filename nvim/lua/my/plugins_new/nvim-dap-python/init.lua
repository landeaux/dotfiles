return {
    "mfussenegger/nvim-dap-python",
    init = function()
        require("my.plugins_new.nvim-dap-python.mappings")
    end,
    config = function()
        require("my.plugins_new.nvim-dap-python.config")
    end,
    dependencies = { "mfussenegger/nvim-dap" },
}
