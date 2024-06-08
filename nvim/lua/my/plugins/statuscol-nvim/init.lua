return {
    "luukvbaal/statuscol.nvim",
    config = function()
        local builtin = require("statuscol.builtin")
        require("statuscol").setup({
            relculright = true,
            ft_ignore = { "gitcommit", "gitrebase", "fugitive", "help", "netrw" },
            segments = {
                { sign = { namespace = { "gitsigns" }, maxwidth = 1, colwidth = 1 }, click = "v:lua.ScSa" },
                { sign = { namespace = { ".*" }, name = { ".*" }, maxwidth = 1, colwidth = 2 }, click = "v:lua.ScSa" },
                { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
                { text = { builtin.foldfunc, " " }, click = "v:lua.ScFa" },
            },
        })
    end,
}
