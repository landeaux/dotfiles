local ok, wk = pcall(require, "which-key")
if ok then
    wk.register({
        l = {
            name = "+lsp",
            p = {
                name = "+peek_definition_code",
            },
        },
    }, { prefix = "<leader>" })
end
