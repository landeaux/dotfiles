return {
    "luukvbaal/statuscol.nvim",
    config = function()
        local builtin = require("statuscol.builtin")
        require("statuscol").setup({
            relculright = true,
            segments = {
                { sign = { name = { "GitSigns" }, maxwidth = 1, colwidth = 1 } },
                { sign = { name = { ".*" }, maxwidth = 1, colwidth = 2 } },
                { text = { builtin.lnumfunc, " " } },
            },
        })
    end,
}
