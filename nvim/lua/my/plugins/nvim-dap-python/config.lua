local dap_python = require("dap-python")

local pyenv_root = vim.fn.getenv("PYENV_ROOT")
if pyenv_root == vim.NIL then
    vim.notify_once("PYENV_ROOT not set! Unable to initialize DAP for python.", vim.log.levels.WARN)
    return
end

local python_path = pyenv_root .. "/versions/debugpy/bin/python"
dap_python.setup(python_path)
dap_python.test_runner = "pytest"
