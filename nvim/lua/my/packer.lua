local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        print("Cloning packer..")
        fn.system({
            "git",
            "clone",
            "--depth",
            "1",
            "https://github.com/wbthomason/packer.nvim",
            install_path,
        })
        print("Packer cloned successfully.")
        vim.cmd([[packadd packer.nvim]])
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()
local packer = require("packer")

-- @TODO: check if snapshot exists, if not create it
packer.init({
    -- TODO: restore this once there is support for better diff view
    -- @see: https://github.com/wbthomason/packer.nvim/issues/459
    -- display = {
    --     open_fn = function()
    --         return require("packer.util").float({ border = "rounded" })
    --     end,
    --     prompt_border = "rounded",
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

return {
    packer = packer,
    packer_bootstrap = packer_bootstrap,
}
