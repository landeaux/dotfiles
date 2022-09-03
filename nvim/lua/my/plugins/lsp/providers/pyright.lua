-- npm i -g pyright
return {
    settings = {
        python = {
            analysis = {
                diagnosticMode = "workspace",
                typeCheckingMode = "off",
            },
            venvPath = vim.env.VIRTUAL_ENV and vim.env.VIRTUAL_ENV or vim.env.PYENV_ROOT,
        },
    },
}
