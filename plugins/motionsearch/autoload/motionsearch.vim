
"'''''''''''''''''''' function! motionsearch#set_opfunc()
function! motionsearch#set_opfunc()
	set opfunc=motionsearch#search_motion
endf


"'''''''''''''''''''' function! motionsearch#set_opfunc_nomove()
function! motionsearch#set_opfunc_nomove()
	let s:search_motion_pos = getcurpos()
	set opfunc=motionsearch#search_motion_nomove
endf


"'''''''''''''''''''' function! motionsearch#search_motion(...)
function! motionsearch#search_motion(...)
	let l:old_reg = @@

	normal! `[v`]y
	let @/ = @@
	normal! n

	let @@ = l:old_reg
endf


"'''''''''''''''''''' function! motionsearch#search_motion_nomove(...)
function! motionsearch#search_motion_nomove(...)
	let l:old_reg = @@

	normal! `[v`]y
	let @/ = '\V' . @@
	set hls
	call setpos('.', s:search_motion_pos)

	let @@ = l:old_reg
endf


