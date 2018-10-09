

"******************** function! s:is_title()
function! s:is_title()
	return match(getline('.'), ':(($') != -1
endf


"******************** function! s:yank_infos()
function! s:yank_infos()
	let l:old_pos = getcurpos()
	" On cherche les lignes de départ et d'arrivée:
	if !s:is_title()
		let l:start_line = search(':(($', 'bnW') + 1
	else
		let l:start_line = line('.') + 1
	endif

	let l:end_line = search('^.*))$', 'nW') - 1
	if l:end_line == -1
		let l:end_line = line('$')
	end

	let l:lines = getline(l:start_line, l:end_line)
	let l:regnames = []
	for l:line in l:lines
		echo l:line
		let l:field = matchstr(l:line, '^\A*\zs.\{-}\ze\s*:')
		let l:content = matchstr(l:line, '^\A*.\{-}\s*:\s*\zs.\{-}\ze\()\{2,}\|\)$')
		let l:regname = tolower(l:field[0])
		call add(l:regnames, l:regname)
		echo printf('%s, "%s"', l:regname, l:content)
		call system(printf('yclip @%s', l:regname), l:content)
	endfor

	call system(printf('pynotify "Les registres %s ont été sauvés"', join(l:regnames, ', ')))

	call setpos('.', l:old_pos)
endf


"******************** function! mdp#fold_text(line)
function! mdp#fold_text(line)
	let l:ret = getline(v:foldstart)
	let l:ret = matchstr(l:ret, '^.*\ze:\s*(($')
	let l:ret = substitute(l:ret, '\t', repeat(' ', &ts), 'g')
	let l:ret .= repeat(' ', 300)
	return l:ret
endf


"******************** function! mdp#install()
function! mdp#install()
	syn match MdpIgnore /(\{2,}/ conceal contained
	syn match MdpIgnore /\((\|)\)\{2,}/ conceal
	syn match MdpH1 /^[^\t].*:(($/ contains=MdpIgnore
	syn match MdpH2 /^\t[^\t].*:(($/ contains=MdpIgnore
	syn match MdpField /^\s*\zs[^:]*\ze:\((($\)\@!/
	set cole=3 cocu=vinc
	set foldlevel=0 foldenable
	set foldtext=mdp#fold_text(v:foldstart)
	map <buffer> <left> zc
	map <buffer> <right> zo
	map <buffer> <c-y> :call <sid>yank_infos()<cr>
endf


"******************** Highlights

hi link MdpH1 Folded
hi link MdpH2 MdpH1
hi MdpIgnore ctermfg=darkgrey guifg=#888888
hi MdpField cterm=bold gui=bold


