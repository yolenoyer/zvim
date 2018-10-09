

"'''''''''''''''''''' function! highlight#get_def(group)
function! highlight#get_def(group)
	redir => l:output
		silent! exec 'hi' a:group
	redir end

	let l:link = matchstr(l:output, 'links to \zs\w\+')

	if empty(l:link)
		return printf('hi %s %s', a:group, matchstr(l:output, '\<xxx \zs[^\n]*'))
	else
		return printf('hi! link %s %s', a:group, l:link)
	endif
endf


"'''''''''''''''''''' function! highlight#set_def(def)
function! highlight#set_def(def)
	exe a:def
endf


