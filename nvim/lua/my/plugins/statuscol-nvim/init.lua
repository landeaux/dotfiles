return {
    "luukvbaal/statuscol.nvim",
    config = function()
        local builtin = require("statuscol.builtin")
        require("statuscol").setup({
            relculright = true,
            segments = {
                { sign = { namespace = { "gitsigns" }, maxwidth = 1, colwidth = 1 } },
                { sign = { namespace = { ".*" }, maxwidth = 1, colwidth = 2 } },
                { text = { builtin.lnumfunc, " " } },
            },
        })
    end,
}
