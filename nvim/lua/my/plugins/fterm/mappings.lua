local custom = require("my.plugins.fterm.custom_terminals")
local fterm = require("FTerm")
local map = require("my.utils").map_factory({ silent = true })

map({ "n", "t" }, "<A-i>", function() fterm:toggle() end, { desc = "Toggle terminal" })

map("t", "<A-x>", function() fterm:exit() end, { desc = "Exit terminal" })

map({ "n", "t" }, "<A-p>", function() custom.python:toggle() end, { desc = "Toggle python shell" })

map({ "n", "t" }, "<A-n>", function() custom.node:toggle() end, { desc = "Toggle node shell" })

map({ "n", "t" }, "<A-t>", function() custom.top:toggle() end, { desc = "Toggle top" })
