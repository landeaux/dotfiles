return {
    settings = {
        json = {
            -- Schemas https://www.schemastore.org
            schemas = require("schemastore").json.schemas({
                extra = {
                    {
                        name = "markdownlint-cli2",
                        url = "https://raw.githubusercontent.com/DavidAnson/markdownlint-cli2/main/schema/markdownlint-cli2-config-schema.json",
                        fileMatch = { ".markdownlint-cli2.jsonc", ".markdownlint-cli2.json" },
                    },
                },
            }),
            validate = { enable = true },
        },
    },
}
