-- npm install -g markdownlint-cli

return {
    -- TODO default to global lintrc
    -- lintcommand = 'markdownlint -s -c ./markdownlintrc',
    prefix = "markdownlint",
    lintCommand = "markdownlint -s",
    lintStdin = true,
    lintFormats = { "%f:%l %m", "%f:%l:%c %m", "%f: %l: %m" },
}
