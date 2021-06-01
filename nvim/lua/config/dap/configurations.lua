local dap = require('dap')

dap.configurations.python = {
  {
    type = 'python';
    request = 'attach';
    name = 'Attach remote (custom)';
    cwd = vim.fn.getcwd();
    host = function()
        local value = vim.fn.input('Host [127.0.0.1]: ')
        if value ~= '' then
            return value
        end
        return '127.0.0.1'
    end;
    port = function()
        return tonumber(vim.fn.input('Port [5678]: ')) or 5678
    end;
    pathMappings = function()
        local remoteRoot = vim.fn.input('Remote Root [/]: ')
        if remoteRoot == '' then
            remoteRoot = '/'
        end;
        return {
            {
                localRoot = vim.fn.getcwd();
                remoteRoot = remoteRoot;
            };
        };
    end;
  },
}
