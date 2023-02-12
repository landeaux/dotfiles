return {
    "heavenshell/vim-pydocstring",
    build = "make install",
    init = function()
        require("my.plugins_new.vim-pydocstring.mappings")
    end,
    config = function()
        require("my.plugins_new.vim-pydocstring.config")
    end,
    ft = "python",
}
