return {
    settings = {
        json = {
            -- Schemas https://www.schemastore.org
            schemas = vim.list_extend(require("schemastore").json.schemas(), {
                {
                    url = "https://raw.githubusercontent.com/DavidAnson/markdownlint-cli2/main/schema/markdownlint-cli2-config-schema.json",
                    fileMatch = { ".markdownlint-cli2.jsonc", ".markdownlint-cli2.json" },
                },
            }),
            validate = { enable = true },
        },
    },
}
