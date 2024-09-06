-- See https://docs.astral.sh/ruff/editors/setup/#neovim

local on_attach = function(client, bufnr)
    if client.name == "ruff" then
        -- Disable hover in favor of Pyright
        client.server_capabilities.hoverProvider = false
    end
end

return {
    on_attach = on_attach,
}
