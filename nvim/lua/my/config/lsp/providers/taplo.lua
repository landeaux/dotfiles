return {
    settings = {
        evenBetterToml = {
            schema = {
                enabled = true,
                repositoryEnabled = true,
                repositoryUrl = "https://taplo.tamasfe.dev/schema_index.json",
            },
            cachePath = vim.fn.stdpath("cache") .. "/taplo",
            formatter = {
                arrayTrailingComma = true,
                arrayAutoExpand = true,
                arrayAutoCollapse = false,
                compactArrays = false,
                compactInlineTables = false,
                indentTables = true,
                trailingNewline = false,
                reorderKeys = true,
            },
        },
    },
}
