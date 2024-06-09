local custom = require("my.plugins.fterm.custom_terminals")
local fterm = require("FTerm")

-- base commands
vim.api.nvim_create_user_command("FTermOpen", fterm.open, { bang = true })
vim.api.nvim_create_user_command("FTermClose", fterm.close, { bang = true })
vim.api.nvim_create_user_command("FTermExit", fterm.exit, { bang = true })
vim.api.nvim_create_user_command("FTermToggle", fterm.toggle, { bang = true })

-- custom commands
vim.api.nvim_create_user_command("Python", function() custom.python:toggle() end, { bang = true })

vim.api.nvim_create_user_command("IPython", function() custom.ipython:toggle() end, { bang = true })

vim.api.nvim_create_user_command("Node", function() custom.node:toggle() end, { bang = true })

vim.api.nvim_create_user_command("Top", function() custom.top:toggle() end, { bang = true })
