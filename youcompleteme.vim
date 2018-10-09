
let g:ycm_confirm_extra_conf = 0 " Lecture du fichier .ycm_extra_conf.py sans confirmation
let g:ycm_auto_trigger = 0 " Auto-complétion désactivée au départ (<c-space> pour utiliser quand même)
let g:ycm_error_symbol = '> '
let g:ycm_warning_symbol = '> '
let g:ycm_enable_diagnostic_highlighting = 0
let g:ycm_global_ycm_extra_conf = '~/scripts/vim/.ycm_extra_conf.py'
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_add_preview_to_completeopt = 1
fun! Ycm_Toggle_Auto_Trigger()
	let g:ycm_auto_trigger=!g:ycm_auto_trigger
	if g:ycm_auto_trigger == 1
		echo "Auto completion activée"
	else
		echo "Auto completion désactivée"
	endif
endf
" Alt-C pour activer/désactiver la complétion auto:
noremap <silent> <m-c> :call Ycm_Toggle_Auto_Trigger()<cr>
inoremap <silent> <f4>yt <c-o>:call Ycm_Toggle_Auto_Trigger()<cr>
noremap <silent> gd :YcmCompleter GoTo<cr>
noremap <silent> <F2>gd :tab split\|YcmCompleter GoTo<cr>

"''''''''''''''''''''     function! s:map_cpp_ycm()
function! s:map_cpp_ycm()
	noremap <buffer> <silent> gt :GoToType<cr>
	noremap <buffer> <silent> <F2>gt :tab split\|GoToType<cr>
	noremap <buffer> <silent> _t :YcmCompleter GetType<cr>
	noremap <buffer> <silent> -t :YcmCompleter GetType<cr>
endf

au FileType c,cpp call s:map_cpp_ycm()


noremap _yt :YcmCompleter GetType<cr>
noremap _yd :YcmCompleter GoTo<cr>
noremap _yf :YcmCompleter FixIt<cr>
noremap _yp :YcmCompleter GetParent<cr>

" En C/C++, va à la définition (sémantique) du type indiqué en paramètre.
command! -nargs=1 JumpToDecl call s:jump_to_decl(<q-args>)

" En C/C++, va à la définition (sémantique) du type de l'objet sous le 
" curseur.
command! -bang GoToType call s:go_to_type(<q-bang>)

"''''''''''''''''''''     function! GetType()
function! GetType()
	redir => message
	silent YcmCompleter GetType
	redir END
	let message = substitute(message, '^\(\s\|\n\)\+\|\(\s\|\n\)\+$',"","g")
	let parts = split(message, '\V => ')
	return parts[0]
endf

"''''''''''''''''''''     function! s:jump_to_decl(name)
" C/C++ only
function! s:jump_to_decl(name)
	call append(line('.'), printf('%s __nom_de_variable__;', a:name))
	normal! j0

	let l:old_buf = bufnr('%')
	let l:old_pos = getcurpos()

	YcmCompleter GoTo

	let l:new_buf = bufnr('%')
	let l:new_pos = getcurpos()
	
	exe printf('buffer %i', l:old_buf)
	" Annulation de call append(...):
	silent normal! u
	exe printf('buffer %i', l:new_buf)
	call setpos('.', l:new_pos)
endf

"''''''''''''''''''''     function! s:go_to_type(bang)
"" C/C++ only
function! s:go_to_type(bang)
	let l:type = GetType()
	if l:type == 'Unknown type'
		echo 'Type inconnu'
		return
	endif

	let l:type_words = split(l:type, '\W\+')

	let l:type_tags = []
	for l:word in l:type_words
		let l:tags = taglist(printf('^%s$', l:word))
		if !empty(l:tags)
			call add(l:type_tags, l:word)
		endif
	endfor

	if a:bang == '!' && len(l:type_tags) == 1
		call s:jump_to_decl(l:type_tags[0])
		return
	endif

	" echo 'Type : '
	echohl Type | echon l:type | echohl None

	if empty(l:type_tags)
		return
	endif

	let l:i = 1
	for l:type_tag in l:type_tags
		echo '   '
		echohl Question | echon printf('%i.', l:i) | echohl None
		echon ' '
		echon l:type_tag
	endfor
	echo "Entrer un chiffre, ou 't' pour le premier choix, ou n'importe quelle autre touche pour annuler"

	while 1
		try
			let l:char = getchar()
		catch /^Vim:Interrupt$/
			" pass
		endtry

		if l:char == "\<LeftMouse>" || l:char == "\<LeftDrag>" || l:char == "\<LeftRelease>"
			continue
		endif

		if l:char == char2nr('t')
			let l:num = 0
		else
			if l:char < char2nr('1') || l:char > char2nr('9')
				" Mauvaise touche
				call feedkeys(" ")
				break
			endif
			let l:num = l:char - char2nr('1')
			if l:num >= len(l:type_tags)
				" Nombre trop grand
				continue
			endif
		endif

		let l:tag = l:type_tags[l:num]
		call s:jump_to_decl(l:tag)
		call feedkeys(" ")
		break
	endw

	" call append(line('.'), join(l:type_words))
endf

" Pour afficher la sign column même quand il n'y a pas de signe, et éviter des
" décalages constants et intempestifs:
sign define transparent_sign
augroup MyYcmAu
	au!
	au BufReadPost *.c,*.cc,*.h,*.cpp,*.hh,*.py,*.js,*.php exe "sign place 1111 name=transparent_sign line=1 file=".@%
augroup end
