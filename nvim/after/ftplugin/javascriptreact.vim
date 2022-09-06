setlocal shiftwidth=2 softtabstop=2 tabstop=2
setlocal isfname+=@-@
setlocal includeexpr=substitute(v:fname,'^@\/','src/','')
setlocal suffixesadd=.js,.vue
