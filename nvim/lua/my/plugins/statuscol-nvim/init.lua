return {
    "luukvbaal/statuscol.nvim",
    config = function()
        local builtin = require("statuscol.builtin")
        require("statuscol").setup({
            relculright = true,
            segments = {
                { text = { " " } },
                { sign = { name = { ".*" }, maxwidth = 1, colwidth = 2 } },
                { text = { builtin.lnumfunc, " " } },
                { sign = { name = { "GitSigns" }, maxwidth = 1, colwidth = 1 } },
            },
        })
    end,
}
