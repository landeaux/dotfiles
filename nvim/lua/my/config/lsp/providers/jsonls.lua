return {
    settings = {
        json = {
            -- Schemas https://www.schemastore.org
            schemas = require('schemastore').json.schemas(),
            validate = { enable = true },
            -- schemas = {
            --     {
            --         fileMatch = { "package.json" },
            --         url = "https://json.schemastore.org/package.json",
            --     },
            --     {
            --         fileMatch = { "jsconfig*.json" },
            --         url = "https://json.schemastore.org/jsconfig.json",
            --     },
            --     {
            --         fileMatch = { "tsconfig*.json" },
            --         url = "https://json.schemastore.org/tsconfig.json",
            --     },
            --     {
            --         fileMatch = {
            --             ".prettierrc",
            --             ".prettierrc.json",
            --             "prettier.config.json",
            --         },
            --         url = "https://json.schemastore.org/prettierrc.json",
            --     },
            --     {
            --         fileMatch = {
            --             ".eslintrc",
            --             ".eslintrc.json",
            --         },
            --         url = "https://json.schemastore.org/eslintrc.json",
            --     },
            --     {
            --         fileMatch = {
            --             ".babelrc",
            --             ".babelrc.json",
            --             "babel.config.json",
            --         },
            --         url = "https://json.schemastore.org/babelrc.json",
            --     },
            --     {
            --         fileMatch = {
            --             ".stylelintrc",
            --             ".stylelintrc.json",
            --             "stylelint.config.json",
            --         },
            --         url = "http://json.schemastore.org/stylelintrc.json",
            --     },
            -- },
        },
    },
}
