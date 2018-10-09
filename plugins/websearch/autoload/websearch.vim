
let s:dev_sites = {
\	'php' : 'http://php.net',
\	'javascript' : 'mdn',
\	'css' : 'mdn',
\}

"'''''''''''''''''''' function! s:getFileType(term)
function! s:getFileType(term)
	if &ft == 'scss'
		return 'css'
	else
		return &ft
	endif
endf

"'''''''''''''''''''' function! websearch#duckduckgoDev(term)
function! websearch#duckduckgoDev(term)
	let l:ft = s:getFileType(a:term)
	let l:extra_search = has_key(s:dev_sites, l:ft) ? s:dev_sites[l:ft] : 'reference'
	let l:search = printf('%s %s %s', l:ft, l:extra_search, fnameescape(a:term))
	exe printf("!lucky '%s'", l:search)
	echo printf("Cherché: '%s'", l:search)
endf

