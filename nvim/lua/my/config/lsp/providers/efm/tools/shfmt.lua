-- go install mvdan.cc/sh/v3/cmd/shfmt@latest

return {
    formatCommand = "shfmt -ci -s -bn",
    formatStdin = true,
}
