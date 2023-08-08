setlocal shiftwidth=2 softtabstop=2 tabstop=2
setlocal indentexpr=nvim_treesitter#indent()
setlocal isfname+=@-@
setlocal includeexpr=substitute(v:fname,'^@\/','src/','')
setlocal suffixesadd=.js,.ts,.vue

setlocal fo+=cro
" inoremap <expr> <enter> getline('.') =~ '^\s*//' ? '<enter><esc>S' : '<enter>'
" nnoremap <expr> O getline('.') =~ '^\s*//' ? 'O<esc>S' : 'O'
" nnoremap <expr> o getline('.') =~ '^\s*//' ? 'o<esc>S' : 'o'
