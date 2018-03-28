
"'''''''''''''''''''' function! morefeatures#duckduckgo(term)
" Ouvre une page web avec le navigateur favori concernant un certain terme de langage, et en
" considérant le type actuel du fichier.
function! morefeatures#duckduckgo(term)
	let l:extra_search = has_key(s:dev_sites, &ft) ? s:dev_sites[&ft] : 'reference'
	exe printf("!lucky '%s %s %s'", &ft, l:extra_search, fnameescape(a:term))
endf

" Liste de mot-clés à rajouter pour certains langages spécifiques:
let s:dev_sites = {
\	'php' : 'http://php.net',
\	'javascript' : 'mdn',
\	'css' : 'mdn',
\}

