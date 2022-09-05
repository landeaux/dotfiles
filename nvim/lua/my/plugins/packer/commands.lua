require("my.utils").create_augroup({
    {
        event = "BufWritePost",
        opts = {
            pattern = "pluginsInit.lua",
            command = "source <afile> | PackerCompile",
        },
    },
}, "_packer")
