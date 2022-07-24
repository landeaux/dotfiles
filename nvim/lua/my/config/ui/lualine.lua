local function lsp_clients()
    local active_clients = vim.tbl_map(function(client)
        return client.name
    end, vim.lsp.get_active_clients())

    return "  " .. table.concat(active_clients, ", ")
end

require("lualine").setup({
    sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { "filename" },
        lualine_x = { lsp_clients, "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
    },
})
