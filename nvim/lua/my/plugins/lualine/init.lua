local function lsp_clients()
    local bufnr = vim.api.nvim_get_current_buf()
    local active_clients = vim.tbl_values(vim.lsp.buf_get_clients(bufnr))

    if vim.tbl_count(active_clients) == 0 then
        return ""
    end

    local client_names = vim.tbl_map(function(client)
        return client.name
    end, active_clients)

    return "  " .. table.concat(client_names, ", ")
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
