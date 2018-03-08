
let s:dev_sites = {
\	'php' : 'http://php.net',
\	'javascript' : 'mdn',
\	'css' : 'mdn',
\}

"'''''''''''''''''''' function! morefeatures#duckduckgo(term)
function! morefeatures#duckduckgo(term)
	let l:extra_search = has_key(s:dev_sites, &ft) ? s:dev_sites[&ft] : 'reference'
	exe printf("!lucky '%s %s %s'", &ft, l:extra_search, fnameescape(a:term))
endf

