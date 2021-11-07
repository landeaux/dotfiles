-- pip install pydocstyle

return {
    prefix = "pydocstyle",
    lintCommand = "[[ $(basename ${INPUT}) != test_* ]] && pydocstyle --convention=numpy ${INPUT}",
    lintFormats = { "%I%f:%l %.%#:", "%Z%*\\s%m" },
}
