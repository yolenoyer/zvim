
if exists("g:loaded_usualfiles") || &cp
	finish
endif

let g:loaded_usual_files = 1
let s:keepcpo = &cpo
set cpo&vim



" Variables de configuration:

" Fichier menu à utiliser:
call _#let_default('g:usualfiles_file', '~/.vim/usualfiles.txt')
" Placement du curseur:
call _#let_default('g:usualfiles_resetCursorPos', v:true)



" Autocommande pour la coloration syntaxique:

augroup usualfiles
	au!
	exe 'au BufReadPost' escape(g:usualfiles_file, ' \') 'set ft=usualfiles'
augroup END



" Highlight groups:

hi! link UsualfilesComment Comment
hi! link UsualfilesMapping Special
hi! link UsualfilesTarget Directory



" Plug mappings:

noremap <plug>UsualfilesTabOpen :call usualfiles#tabOpen()<cr>
noremap <plug>UsualfilesOpen :call usualfiles#open()<cr>



let &cpo= s:keepcpo
unlet s:keepcpo
