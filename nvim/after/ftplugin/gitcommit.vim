let &colorcolumn=""

setlocal nonumber norelativenumber
setlocal spell

augroup DisableLastPositionJump
    autocmd! BufWinEnter <buffer> execute 'normal! gg0' | autocmd! DisableLastPositionJump BufWinEnter <buffer>
augroup END
