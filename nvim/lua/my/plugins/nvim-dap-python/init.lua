local dap_python = require("dap-python")

local python_path = vim.fn.getenv("PYENV_ROOT") .. "/versions/debugpy/bin/python"
dap_python.setup(python_path)
dap_python.test_runner = "pytest"
