-- npm i -g pyright
return {
    settings = {
        pyright = {
            -- Using Ruff's import organizer
            disableOrganizeImports = true,
        },
        python = {
            analysis = {
                diagnosticMode = "workspace",
                typeCheckingMode = "off",
                ignore = { "*" },
            },
            venvPath = vim.env.VIRTUAL_ENV and vim.env.VIRTUAL_ENV or vim.env.PYENV_ROOT,
        },
    },
}
