return {
    "heavenshell/vim-pydocstring",
    build = "make install",
    init = function()
        require("my.plugins.vim-pydocstring.mappings")
    end,
    config = function()
        require("my.plugins.vim-pydocstring.config")
    end,
    ft = "python",
}
