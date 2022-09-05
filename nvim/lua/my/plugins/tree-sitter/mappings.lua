local ok, wk = pcall(require, "which-key")
if ok then
    wk.register({
        [">"] = "TS: Swap next parameter",
        ["<"] = "TS: Swap previous parameter",
        l = {
            name = "+lsp",
            p = {
                name = "+peek_definition_code",
                f = "Peek funtion definition",
                c = "Peek class definition",
            },
        },
    }, { prefix = "<leader>" })
end
