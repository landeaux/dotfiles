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
vim.cmd('autocmd BufRead,BufNewFile *.graphql,*.graphqls,*.gql set filetype=graphql')

-- highlight on yank
vim.cmd('autocmd TextYankPost * lua vim.highlight.on_yank {on_visual = false}')

-- prevent Python auto indent when pressing colon (:) key
-- autocmd FileType python setlocal indentkeys-=<:>
-- autocmd FileType python setlocal indentkeys-=:

-- set lua indentation rules
vim.cmd('autocmd BufNewFile,BufRead *.lua setlocal tabstop=4 softtabstop=4 shiftwidth=4')
