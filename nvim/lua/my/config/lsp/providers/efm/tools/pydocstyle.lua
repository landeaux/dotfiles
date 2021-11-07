local pydocstyle = {
    prefix = "pydocstyle",
    lintCommand = "[[ $(basename ${INPUT}) != test_* ]] && pydocstyle --convention=numpy ${INPUT}",
    lintFormats = { "%I%f:%l %.%#:", "%Z%*\\s%m" },
}

return pydocstyle
