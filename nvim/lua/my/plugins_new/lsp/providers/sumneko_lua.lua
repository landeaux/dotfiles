-- https://github.com/sumneko/lua-language-server/wiki/Build-and-Run-(Standalone)
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

return {
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = "LuaJIT",
                -- Setup your lua path
                path = runtime_path,
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { "vim" },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
                -- library = {
                --     [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                --     [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                -- },
                checkThirdParty = false,
                maxPreload = 10000,
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
}
