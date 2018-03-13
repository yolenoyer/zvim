
let s:return_mode = v:false


"'''''''''''''''''''' function! returnkey#disp_state(old_mode)
function! returnkey#disp_state(old_mode)
	if a:old_mode != s:return_mode
		if s:return_mode == 1
			echo "Return mode actif"
		else
			echo "Return mode inactif"
		endif
	else
		if s:return_mode == 1
			echo "Return mode déjà actif"
		else
			echo "Return mode déjà inactif"
		endif
	endif
endf


"'''''''''''''''''''' function! s:install()
function! s:install()
	nnoremap <cr> o
	inoremap <cr> <esc>
	inoremap <c-cr> <cr>
endf


"'''''''''''''''''''' function! s:uninstall()
function! s:uninstall()
	nunmap <cr>
	iunmap <cr>
	inoremap <c-cr> <esc>
endf


"'''''''''''''''''''' function! returnkey#set_mode(action, verbose)
function! returnkey#set_mode(action, verbose)
	let l:old_mode = s:return_mode

	if a:action == 'on'
		let s:return_mode = v:true
	elseif a:action == 'off'
		let s:return_mode = v:false
	elseif a:action == 'toggle'
		let s:return_mode = !s:return_mode
	else
		let s:return_mode = a:action
	endif

	if s:return_mode != l:old_mode
		if s:return_mode == 1
			call s:install()
		else
			call s:uninstall()
		endif
	endif

	if a:verbose == 1
		call returnkey#disp_state(l:old_mode)
	endif
endf


"'''''''''''''''''''' function! returnkey#get_mode()
function! returnkey#get_mode()
	return s:return_mode
endf


"'''''''''''''''''''' function! returnkey#set_on()
function! returnkey#set_on()
	call returnkey#set_mode('on', 1)
endf


"'''''''''''''''''''' function! returnkey#set_off()
function! returnkey#set_off()
	call returnkey#set_mode('off', 1)
endf


