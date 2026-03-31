return {
    filetypes = {
        "astro",
        "css",
        "eruby",
        "html",
        "htmldjango",
        "javascript",
        "javascriptreact",
        "less",
        "markdown",
        "php",
        "sass",
        "scss",
        "svelte",
        "typescript",
        "typescriptreact",
        "vue",
    },
    settings = {
        tailwindCSS = {
            classAttributes = {
                "class",
                "className",
                "class:list",
                "classList",
                "ngClass",
                "active-class", -- For Vue Router RouterLink component
                "exact-active-class", -- For Vue Router RouterLink component
            },
            experimental = {
                classRegex = {
                    { "Classes\\s*=\\s*['\"`]([^'\"`]*)['\"`]" },
                },
            },
        },
    },
}
