

"'''''''''''''''''''' function! s:get_current_infos()
function! s:get_current_infos()
	let l:cur_infos = {}
	let l:infos = get(g:funcheader_langdefs, &ft, {})

	let l:fillchar = get(l:infos, 'fillchar', g:funcheader_default_fillchar)

	if has_key(l:infos, 'leader')
		let l:leader = l:infos['leader']
	else
		let l:leader = _#get_comment_leader()
		if l:leader == v:none
			call _#error('funcheader', "Aucun leader de commentaire n'a été détecté")
			return v:none
		endif
	endif

	let l:stripend = get(l:infos, 'stripend', '')
	let l:stripend = printf('\s*%s\s*$', l:stripend)

	let l:fillwidth = get(l:infos, 'fillwidth', g:funcheader_default_fillwidth)

	return {
	\   'fillchar' : l:fillchar,
	\   'leader' : l:leader,
	\   'stripend' : l:stripend,
	\   'fillwidth' : l:fillwidth,
	\ }
endf


"'''''''''''''''''''' function! s:get_banner(infos)
function! s:get_banner(infos)
	let l:banner = a:infos['leader']
	let l:banner .= repeat(a:infos['fillchar'], a:infos['fillwidth'])
	return l:banner
endf


"'''''''''''''''''''' function! funcheader#add_header()
" Ajoute un header perso à une fonction
function! funcheader#add_header()
	let l:infos = s:get_current_infos()
	if type(l:infos) != v:t_dict
		return
	endif

	let l:line = getline('.')

	" On stock l'indentation actuelle pour la reporter sur le header:
	let l:indent = matchstr(l:line, '^\s*')

	" On supprime l'indentation de la ligne:
	let l:line = substitute(l:line, '^\s\+', '', '')
	" On supprime les caractères finaux non-souhaités (accolade,...):
	let l:line = substitute(l:line, l:infos['stripend'], '', '')

	let l:line = printf('%s%s %s', l:indent, s:get_banner(l:infos), l:line)

	call append(line('.') - 1, l:line)
endf


