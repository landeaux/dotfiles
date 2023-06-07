-- vim: ft=lua tw=120 sw=4 sts=4 ts=4

-- Rerun tests only if their modification time changed.
cache = true

ignore = {
    "212", -- Unused argument, In the case of callback function, _arg_name is easier to understand than _, so this option is set to off.
    "121",
    "122",
}

-- Global objects defined by the C code
read_globals = {
    "vim",
}

include_files = {
    "./nvim/lua/",
}

exclude_files = {
    "./nvim/lua/my/compiled.lua",
}
