return {
    filetypes = { "yaml", "yaml.docker-compose", "yaml.ansible" },
    settings = {
        yaml = {
            -- Schemas https://www.schemastore.org
            schemas = require("schemastore").yaml.schemas({
                extra = {
                    {
                        name = "docker-stack",
                        url = "https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json",
                        fileMatch = {
                            "**/docker-stack.yml",
                            "**/docker-stack.yaml",
                            "**/docker-stack.*.yml",
                            "**/docker-stack.*.yaml",
                        },
                    },
                },
            }),
            -- yamlls' own fetcher would otherwise pull the same catalog and conflict with schemastore.nvim's.
            schemaStore = {
                enable = false,
                url = "",
            },
            customTags = { "!reference sequence" },
        },
    },
}
