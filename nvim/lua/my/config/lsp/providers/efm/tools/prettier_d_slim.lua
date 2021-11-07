-- npm add --global prettier_d_slim

return {
    formatCommand = "prettier_d_slim --single-quote true --stdin --stdin-filepath ${INPUT}",
    formatStdin = true,
}
