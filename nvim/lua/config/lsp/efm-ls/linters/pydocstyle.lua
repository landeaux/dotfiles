local pydocstyle = {
    lintCommand = "pydocstyle --convention=numpy ${INPUT}",
    lintFormats = {"%I%f:%l %.%#:", "%Z%*\\s%m"}
}

return pydocstyle
