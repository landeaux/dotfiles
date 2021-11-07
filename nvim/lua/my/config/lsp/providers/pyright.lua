-- npm i -g pyright
return {
    settings = {
        python = {
            analysis = {
                diagnosticMode = "workspace",
                typeCheckingMode = "off",
            },
            venvPath = vim.env.PYENV_ROOT,
        },
    },
}
