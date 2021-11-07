-- npm install --global @fsouza/prettierd

return {
    formatCommand = "prettierd ${INPUT}",
    formatStdin = true,
    -- env = {'PRETTIERD_DEFAULT_CONFIG=~/.config/nvim/utils/linter-config/.prettierrc.json'}
}
