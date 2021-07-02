local flake8 = {
    lintCommand = "flake8 --ignore=E501 --ignore=W503 --stdin-display-name ${INPUT} -",
    lintStdin = true,
    lintFormats = { "%f:%l:%c: %m" },
}

return flake8
