setlocal shiftwidth=2 softtabstop=2 tabstop=2
setlocal indentexpr=nvim_treesitter#indent()
setlocal isfname+=@-@
setlocal includeexpr=substitute(v:fname,'^@\/','src/','')
setlocal suffixesadd=.js,.vue
