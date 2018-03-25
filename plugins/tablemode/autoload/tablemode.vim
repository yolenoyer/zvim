
let s:is_active = v:false
let s:in_cr = v:false


"'''''''''''''''''''' function! tablemode#do_cr()
function! tablemode#do_cr()
	exe printf("normal! j%s\<bar>", s:start_col)
	let s:in_cr = v:false
endf


"'''''''''''''''''''' function! tablemode#cr_wrapper()
function! tablemode#cr_wrapper()
	let s:in_cr = v:true
	return "\<esc>:call tablemode#do_cr()\<cr>i"
endf


"'''''''''''''''''''' function! tablemode#toggle_wrapper()
function! tablemode#toggle_wrapper()
	call tablemode#toggle()
	return ''
endf


"'''''''''''''''''''' function! tablemode#activate()
function! tablemode#activate()
	if s:is_active
		return
	endif
	let s:is_active = v:true
	let s:start_col = virtcol('.')
	call _#set_temp_option('virtualedit', 'all')
	inoremap <expr> <buffer> <cr> tablemode#cr_wrapper()
	augroup tablemode
		au!
		au InsertLeave <buffer> call tablemode#deactivate()
	augroup END
endf


"'''''''''''''''''''' function! tablemode#deactivate()
function! tablemode#deactivate()
	if !s:is_active || s:in_cr
		return
	endif
	let s:is_active = v:false
	call _#restore_option('virtualedit')
	iunmap <buffer> <cr>
	augroup tablemode
		au!
	augroup END
endf


"'''''''''''''''''''' function! tablemode#toggle()
function! tablemode#toggle()
	if s:is_active
		call tablemode#deactivate()
	else
		call tablemode#activate()
	endif
endf


"'''''''''''''''''''' function! tablemode#is_active()
function! tablemode#is_active()
	return s:is_active
endf

