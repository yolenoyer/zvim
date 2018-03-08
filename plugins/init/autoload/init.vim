
function! init#get_motions_chars(mode)
	echo "In:"
	let l:c = getchar() | redraw
	if type(l:c) != 0 | return | endif
	let l:char1 = nr2char(l:c)
	echo "Out:" | redraw
	let l:c = getchar()
	if type(l:c) != 0 | return | endif
	let l:char2 = nr2char(l:c)
	if a:mode == 0
		exe printf('normal lT%svt%s', l:char1, l:char2)
	else
		exe printf('normal lF%svf%s', l:char1, l:char2)
	endif
	echo ' '
endf

