return {
    settings = {
        basedpyright = {
            disableOrganizeImports = true, -- Using Ruff's import organizer
            analysis = {
                diagnosticMode = "workspace",
                typeCheckingMode = "off",
                ignore = { "*" },
            },
        },
        python = {
            venvPath = vim.env.VIRTUAL_ENV and vim.env.VIRTUAL_ENV or vim.env.PYENV_ROOT,
        },
    },
}
