
"'''''''''''''''''''' function! buf#buf(...)
function! buf#buf(...)
	let l:command = [ 'buf', '-n' ]
	if a:0 > 0
		call add(l:command, a:1)
	endif
	let l:data = _#trim(_#system(l:command))
	return l:data
endf

