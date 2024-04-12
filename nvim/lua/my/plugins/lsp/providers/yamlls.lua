return {
    settings = {
        yaml = {
            schemas = {
                ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = {
                    "**/docker-stack.yml",
                    "**/docker-stack.yaml",
                    "**/docker-stack.*.yml",
                    "**/docker-stack.*.yaml",
                },
            },
            customTags = { "!reference sequence" },
        },
    },
}
