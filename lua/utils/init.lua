local utils = { }

local scopes = {o = vim.o, b = vim.bo, w = vim.wo}
local execute = vim.api.nvim_exec

function utils.opt(scope, key, value)
	scopes[scope][key] = value
	if scope ~= 'o' then scopes['o'][key] = value end
end

function utils.map(mode, lhs, rhs, opts)
	local options = {noremap = true}
	if opts then options = vim.tbl_extend('force', options, opts) end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- escape terminal codes and keycodes
function utils.t(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

-- gets the highlight value for the given group and term
function utils.get_hi_term(group, term)
  local output = execute('hi ' .. group, true)
  return vim.fn.matchstr(output, term .. '=\\zs\\S*')
end

-- Create an augroup
function utils.create_augroup(autocmds, name)
    vim.cmd('augroup ' .. name)
    vim.cmd('autocmd!')

    for _, autocmd in ipairs(autocmds) do
        vim.cmd('autocmd ' .. table.concat(autocmd, ' '))
    end

    vim.cmd('augroup END')
end

return utils
