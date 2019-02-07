
" if exists("b:current_syntax")
"     finish
" endif

syn keyword	GitignoreTodo contained TODO FIXME XXX
syn match GitignoreComment "^#.*" contains=GitignoreTodo
syn match GitignoreComment "\s#.*"ms=s+1 contains=GitignoreTodo
syn match GitignoreNegate "^!.*" contains=GitignoreTodo
syn match GitignoreFile "^[^#!].*"


hi link GitignoreTodo Todo
hi link GitignoreComment Comment
hi GitignoreNegate ctermfg=red guifg=red
hi link GitignoreFile Type


let b:current_syntax = 'gitignore'

setlocal commentstring=#%s
