" Adapted from https://github.com/drgarcia1986/python-compilers.vim

if exists("current_compiler")
  finish
endif
let current_compiler = "ruff"

if exists(":CompilerSet") != 2                " older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

let s:cpo_save = &cpo
set cpo-=C

CompilerSet makeprg=ruff\ check\ %\ -q
CompilerSet errorformat=%f:%l:%c:\ %m

let &cpo = s:cpo_save
unlet s:cpo_save
