-- npm install --global @fsouza/prettierd
local prettierd = {
    formatCommand = 'prettierd ${INPUT}',
    formatStdin = true
    -- env = {'PRETTIERD_DEFAULT_CONFIG=~/.config/nvim/utils/linter-config/.prettierrc.json'}
}

return prettierd
