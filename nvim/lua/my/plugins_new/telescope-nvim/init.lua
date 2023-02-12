return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    init = function()
        require("my.plugins_new.telescope-nvim.mappings")
    end,
    config = function()
        require("my.plugins_new.telescope-nvim.config")
    end,
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-dap.nvim", dependencies = { "mfussenegger/nvim-dap", } },
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
}
