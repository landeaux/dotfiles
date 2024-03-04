return {
    init_options = {
        plugins = {
            {
                name = "@vue/typescript-plugin",
                location = vim.env.NVM_DIR .. "/versions/node/v18.13.0/lib/node_modules/@vue/typescript-plugin",
                languages = { "javascript", "typescript", "vue" },
            },
        },
    },
    filetypes = {
        "javascript",
        "typescript",
        "vue",
    },
}
