-- https://github.com/jgm/pandoc

return {
    formatCommand = "pandoc -f markdown -t gfm -sp --tab-stop=2",
    formatStdin = true,
}
