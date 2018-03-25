

"'''''''''''''''''''' function! s:error(...)
function! _#error(...)
	if a:0 == 1
		echoerr a:1
	elseif a:0 == 2
		echoerr printf('Plugin %s: %s', a:1, a:2)
	endif
endf



"'''''''''''''''''''' function! _#system(...)
function! _#system(...)
	let l:command = []
	for l:arg in a:000
		if (type(l:arg) == v:t_string)
			let l:new_args = [ shellescape(l:arg) ]
		elseif (type(l:arg) == v:t_list)
			let l:new_args = map(l:arg, { k, v -> shellescape(v) })
		else
			continue
		endif
		call extend(l:command, l:new_args)
	endfor
	let l:out = system(join(l:command))
	return l:out
endf



"'''''''''''''''''''' function! _#let_default(var_name, default_val)
function! _#let_default(var_name, default_val)
	if (!exists(a:var_name))
		let {a:var_name} = a:default_val
	endif
endf



"'''''''''''''''''''' function! _#exists_eq(var, val)
function! _#exists_eq(var, val)
	return exists(a:var) && {a:var} == a:val
endf



"'''''''''''''''''''' function! _#cabbr(...)
function! _#cabbr(...)
	if a:0 == 2 && type(a:1)==v:t_string && type(a:2)==v:t_string
		call s:cabbr(a:1, a:2)
	elseif type(a:1) == v:t_dict
		for l:alias in keys(a:1)
			let l:replace = a:1[l:alias]
			call s:cabbr(l:alias, l:replace)
		endfor
	endif
endf

function! s:cabbr(alias, replace)
	if exists('*CmdAlias')
		call CmdAlias(a:alias, a:replace)
	else
		exe 'cabbr' a:alias a:replace
	endif
endf



"'''''''''''''''''''' function! _#relative_path(from_path, target)
function! _#relative_path(from_path, target)
py3 << EOF
import os
rel_path = os.path.relpath(vim.eval('a:target'), vim.eval('a:from_path'))
vim.command('let l:ret = "{}"'.format(rel_path))
EOF
	return l:ret
endf



"'''''''''''''''''''' function! _#filter_completion(completion_list, lead, ...)
" @param a:1  Si =1, alors ajoute un espace lorsqu'il n'y a qu'un choix
function! _#filter_completion(completion_list, lead, ...)
	let l:len = strlen(a:lead)
	call filter(a:completion_list, { i, f -> strpart(f, 0, l:len) == a:lead })
	if len(a:completion_list) == 1 && a:0 > 0 && a:1
		let a:completion_list[0] = a:completion_list[0] . ' '
	endif
	return a:completion_list
endf



"''''''''''''''''''''     function! _#get_visual()
function! _#get_visual()
	let [lnum1, col1] = getpos("'<")[1:2]
	let [lnum2, col2] = getpos("'>")[1:2]
	let lines = getline(lnum1, lnum2)
	let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
	let lines[0] = lines[0][col1 - 1:]
	return join(lines, "\n")
endfunction



"'''''''''''''''''''' function! _#capitalize(str)
function! _#capitalize(str)
	if empty(a:str)
		return ''
	endif
	return toupper(a:str[0]) . strpart(a:str, 1)
endf



"'''''''''''''''''''' function! _#get_all_matches(str, pat)
function! _#get_all_matches(expr, pat)
	let l:matches = []
	let l:count = 1
	while 1
		let l:str = matchstr(a:expr, a:pat, 0, l:count)
		if empty(l:str)
			break
		endif
		if index(l:matches, l:str) == -1
			call add(l:matches, l:str)
		endif
		let l:count += 1
	endw
	return l:matches
endf



"'''''''''''''''''''' function! s:option_string_repr(value)
function! s:option_string_repr(value)
	let l:value = a:value
	if type(l:value) == v:t_bool
		let l:value = !!l:value
	endif
	return printf('"%s"', escape(l:value, '"\'))
endf



"'''''''''''''''''''' function! s:set_option(option_name, value)
function! s:set_option(option_name, value)
	exe printf("let &%s = %s", a:option_name, s:option_string_repr(a:value))
endf



"'''''''''''''''''''' function! _#set_temp_option(option_name, value)
" Définit une option, mais sauvegarde son ancienne valeur auparavant, qu'on peut rappler grâce à la
" fonction _#restore_option().
function! _#set_temp_option(option_name, value)
	let l:var_name = 's:'.a:option_name
	let {l:var_name} = eval('&'.a:option_name)
	call s:set_option(a:option_name, a:value)
endf



"'''''''''''''''''''' function! _#restore_option(option_name)
" Restore une option définie par _#set_temp_option().
function! _#restore_option(option_name)
	let l:var_name = 's:'.a:option_name
	call s:set_option(a:option_name, {l:var_name})
endf



"'''''''''''''''''''' function! _#toggle_option(option_name, values, ...)
function! _#toggle_option(option_name, values, ...)
	let l:current_value = eval('&'.a:option_name)
	for i in range(len(a:values))
		let l:val = a:values[i]
		if l:val == l:current_value
			let l:new_i = (i + 1) % len(a:values)
			call s:set_option(a:option_name, a:values[l:new_i])
			if a:0 > 0 && a:1 == v:true
				exe printf('set %s?', a:option_name)
			endif
			return v:true
		endif
	endfor
	return v:false
endf



"'''''''''''''''''''' function! _#set_mapleader(val)
function! _#set_mapleader(val)
	let s:old_mapleader = exists('mapleader') ? mapleader : v:none
	let g:mapleader = a:val
endf



"'''''''''''''''''''' function! _#set_mapleader_from_var(varname)
function! _#set_mapleader_from_var(varname)
	if exists(a:varname)
		call _#set_mapleader({a:varname})
	else
		if exists('g:mapleader')
			call _#set_mapleader(g:mapleader)
		else
			call _#set_mapleader('\')
		endif
	endif
endf



"'''''''''''''''''''' function! _#restore_mapleader()
function! _#restore_mapleader()
	if !exists('s:old_mapleader')
		return
	endif
	if s:old_mapleader != v:none
		let g:mapleader = s:old_mapleader
	elseif exists('g:mapleader')
		unlet g:mapleader
	endif
	unlet s:old_mapleader
endf

