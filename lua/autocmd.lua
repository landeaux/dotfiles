-- add custom filetype mappings
vim.cmd('autocmd BufRead,BufNewFile .env.* set filetype=sh')
vim.cmd('autocmd BufRead,BufNewFile .gitconfig.local set filetype=gitconfig')
vim.cmd('autocmd BufRead,BufNewFile .pylintrc set filetype=conf')
vim.cmd('autocmd BufRead,BufNewFile .tmux.conf.local set filetype=tmux')
vim.cmd('autocmd BufRead,BufNewFile .zshrc.local set filetype=sh')
vim.cmd('autocmd BufRead,BufNewFile Dockerfile.* set filetype=dockerfile')
vim.cmd('autocmd BufRead,BufNewFile Dockerfile-* set filetype=dockerfile')
vim.cmd('autocmd BufRead,BufNewFile gitconfig set filetype=gitconfig')
vim.cmd('autocmd BufRead,BufNewFile gitignore set filetype=conf')

-- prevent Python auto indent when pressing colon (:) key
-- autocmd FileType python setlocal indentkeys-=<:>
-- autocmd FileType python setlocal indentkeys-=:

