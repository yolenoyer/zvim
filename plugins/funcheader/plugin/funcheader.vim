
call _#let_default('g:funcheader_langdefs', {})
let g:funcheader_langdefs = extend(g:funcheader_langdefs, {
\   'cpp' : {
\       'fillchar' : '*',
\       'stripend' : '{',
\   },
\   'js' : {
\       'fillchar' : '*',
\       'stripend' : '{',
\   },
\   'python' : {
\       'fillchar' : '-',
\       'stripend' : ':',
\   },
\   'sh' : {
\       'fillchar' : '-',
\   },
\   'vim' : {
\       'fillchar' : "'",
\   },
\ })


call _#let_default('g:funcheader_default_fillwidth', 20)

call _#let_default('g:funcheader_default_fillchar', '*')


" Plug mappings:

nnoremap <plug>FuncheaderHeader :call funcheader#add_header()<cr>

