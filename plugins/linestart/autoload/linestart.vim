
"'''''''''''''''''''' function! linestart#go()
function! linestart#go()
	let l:line = getline('.')
	let l:cur_column = getpos('.')[2]
	let l:content_ofs = match(l:line, '^\s*\zs')+1

	if l:cur_column == l:content_ofs
		norm! 0
	else
		norm! ^
	endif
endf

