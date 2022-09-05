vim.keymap.set("n", "<Leader>ti", "<cmd>IndentBlanklineToggle<CR>", { silent = true })

local ok, wk = pcall(require, "which-key")
if ok then
    wk.register({ t = { name = "+ui-toggle", i = "Indent guides" } }, { prefix = "<leader>" })
end
