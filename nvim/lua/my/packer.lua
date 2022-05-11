local cmd = vim.cmd

local present, packer = pcall(require, "packer")

local first_install = false

if not present then
    local packer_path = vim.fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"

    print("Cloning packer..")
    -- remove the dir before cloning
    vim.fn.delete(packer_path, "rf")
    vim.fn.system({
        "git",
        "clone",
        "https://github.com/wbthomason/packer.nvim",
        "--depth",
        "20",
        packer_path,
    })

    cmd("packadd packer.nvim")
    present, packer = pcall(require, "packer")

    if present then
        print("Packer cloned successfully.")
        first_install = true
    else
        error("Couldn't clone packer !\nPacker path: " .. packer_path .. "\n" .. packer)
    end
end

packer.init({
    -- TODO: restore this once there is support for better diff view
    -- display = {
    --     open_fn = function()
    --         return require("packer.util").float({ border = "single" })
    --     end,
    --     prompt_border = "single",
    -- },
    git = {
        clone_timeout = 800, -- Timeout, in seconds, for git clones
    },
    compile_path = vim.fn.stdpath("config") .. "/lua/my/compiled.lua",
    auto_clean = true,
    compile_on_sync = true,
    -- profile = {
    --     enable = true,
    --     threshold = 1,
    -- },
})

local async = require("plenary.async")
local packer_sync = function()
    async.run(function()
        vim.notify.async("Syncing packer.", "info", {
            title = "Packer",
        })
    end, nil)
    local snap_shot_time = os.date("!%Y-%m-%dT%TZ")
    vim.cmd("PackerSnapshot " .. snap_shot_time)
    vim.cmd("PackerSync")
end

vim.keymap.set("n", "<leader>ps", "", {
    callback = packer_sync,
})

return {
    packer = packer,
    first_install = first_install,
}
