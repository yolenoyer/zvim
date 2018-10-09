

"'''''''''''''''''''' function! substall#substitute(word, subst, flags)
function! substall#substitute(word, subst, flags)
	let l:gref_search = a:word
	let l:s_search = a:word

	if stridx(a:flags, 'w') != -1
		let l:gref_search = printf('\b%s\b', a:word)
		let l:s_search = printf('\<%s\>', a:word)
	endif

	let l:gref_file_list_args = [ l:gref_search ]
	let l:s_flags = 'g'

	if stridx(a:flags, 'c') != -1
		let l:s_flags .= 'c'
	endif

	if stridx(a:flags, 'i') != -1
		call add(l:gref_file_list_args, '-i')
		let l:s_flags .= 'i'
	endif

	let l:files = call('gref#get_file_list', l:gref_file_list_args)

	let l:s_command = printf('%%s/%s/%s/%s' , l:s_search, a:subst, l:s_flags)

	for l:file in l:files
		exe 'e' l:file
		exe l:s_command
	endfor

endf

