local lspconfig_util = require("lspconfig.util")

local function get_typescript_lib_path(root_dir)
    local project_root = lspconfig_util.find_node_modules_ancestor(root_dir)
    local local_tsserverlib = project_root ~= nil
        and lspconfig_util.path.join(project_root, "node_modules", "typescript", "lib")
    if local_tsserverlib and lspconfig_util.path.exists(local_tsserverlib) then
        return local_tsserverlib
    else
        local volar = require("mason-registry").get_package("vue-language-server")
        local volar_install_path = volar:get_install_path()
        local global_tsserverlib = volar_install_path .. "/node_modules/typescript/lib"
        return global_tsserverlib
    end
end

local function on_new_config(new_config, new_root_dir)
    new_config.init_options.typescript.tsdk = get_typescript_lib_path(new_root_dir)
end

return {
    settings = {
        volar = {
            codeLens = {
                scriptSetupTools = true,
                references = true,
                pugTools = false,
            },
            autoCompleteRefs = true,
            completion = {
                autoImportComponent = true,
                trimVueFromImportName = true,
            },
        },
    },
    on_new_config = on_new_config,
}
