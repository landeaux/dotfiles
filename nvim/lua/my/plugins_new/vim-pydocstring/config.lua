local formatter = "numpy"
vim.g.pydocstring_doq_path = vim.fn.expand("~/.local/bin/doq")
vim.g.pydocstring_templates_path = vim.fn.stdpath("config")
    .. "/lua/my/plugins_new/vim-pydocstring/templates/"
    .. formatter
vim.g.pydocstring_formatter = formatter
