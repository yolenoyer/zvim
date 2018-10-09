
"'''''''''''''''''''' function! s:get_scope_args()
function! s:get_scope_args(is_global)
	if type(a:is_global) == v:t_string
		if isdirectory(a:is_global)
			return [ '-C', a:is_global ]
		elseif filereadable(a:is_global)
			return [ '-C', fnamemodify(a:is_global, ':p:h') ]
		else
			throw printf("Argument non-valable: '%s'", a:is_global)
		endif
	endif

	if a:is_global
		return [ '-L', g:pysv_svinfo_global ]
	else
		return [ '-C', getcwd() ]
	endif
endf



"'''''''''''''''''''' function! pysv#get_shortcuts(is_global)
function! pysv#get_shortcuts(is_global)
	let l:command = [ g:pysv_binary, '--list', '--json' ]
	let l:command += s:get_scope_args(a:is_global)
	let l:output = _#system(l:command)
	if v:shell_error != 0
		throw l:output
	endif
	return json_decode(l:output)
endf



"'''''''''''''''''''' function! pysv#get_root(is_global)
function! pysv#get_root(is_global, ...)
	let l:command = [ g:pysv_binary, '--get-project-dir' ]
	let l:command += s:get_scope_args(a:is_global)
	let l:output = _#system(l:command)
	if v:shell_error != 0
		if a:0 >= 1 && a:1
			return v:none
		else
			throw l:output
		endif
	endif
	return _#trim(l:output)
endf



"'''''''''''''''''''' function! pysv#get_path(is_global, key)
function! pysv#get_path(is_global, key)
	if a:key == '/' || a:key == ''
		return pysv#get_root(a:is_global)
	endif

	let l:shortcuts = pysv#get_shortcuts(a:is_global)
	if !has_key(l:shortcuts, a:key)
		throw printf("Le raccourci '%s' n'existe pas", a:key)
	endif

	let l:path = l:shortcuts[a:key]
	if !isdirectory(l:path)
		throw printf("Le chemin '%s' n'est pas un répertoire", l:path)
	endif

	return l:path
endf



"'''''''''''''''''''' function! s:common_sv(is_global, key, ...)
function! s:common_sv(is_global, key, ...)
	try
		let l:path = pysv#get_path(a:is_global, a:key)
	catch
		call _#error('pysv', v:exception)
	endtry

	let l:command = a:0 >= 1 && a:1 ? 'lcd' : 'cd'
	let l:path = escape(l:path, ' \')
	let l:command = join([ l:command, l:path ], ' ')

	echo l:command
	exe l:command
endf



"'''''''''''''''''''' function! s:common_complete(is_global, lead, ...)
" @param a:1  Si =v:true, aloars ajoute
function! s:common_complete(is_global, lead, ...)
	try
		let l:shortcuts = pysv#get_shortcuts(a:is_global)
	catch
		return []
	endtry
	let l:keys = keys(l:shortcuts)
	return _#filter_completion(l:keys, a:lead)
endf



"'''''''''''''''''''' function! pysv#parse_path()
function! pysv#parse_path(path)
	let l:infos = {
		\ 'key': v:none,
		\ 'root_path': v:none,
		\ 'relative_path': v:none,
		\ 'whole_path': v:none,
		\ 'files_with_same_prefix': v:none,
		\ 'relative_path_start': v:none,
	\ }

	let l:first_slash = stridx(a:path, '/')
	if l:first_slash != -1
		let l:infos.key = strpart(a:path, 0, l:first_slash)
		let l:infos.root_path = pysv#get_path(0, l:infos.key)
		let l:infos.relative_path = strpart(a:path, l:first_slash + 1)
		let l:infos.whole_path = printf('%s/%s', l:infos.root_path, l:infos.relative_path)
		let l:infos.files_with_same_prefix = glob(printf('%s*', l:infos.whole_path), 0, 1)
		let l:infos.relative_path_start = len(l:infos.root_path) + 1
	else
		let l:infos.key = a:path
	endif

	return l:infos
endf



"'''''''''''''''''''' function! pysv#sv(key, ...)
function! pysv#sv(key, ...)
	call call('s:common_sv', [ v:false, a:key ] + a:000)
endf



"''''''''''''''''''''function! pysv#sve(sv_path, ...)
function! pysv#sve(sv_path, ...)
	let l:edit_command = a:0 >= 1 && a:1 ? 'tabe' : 'e'
	let l:edit_command = (a:0 < 2 || a:0 >= 2 && a:2) ? l:edit_command : 'Tabi'

	let l:infos = pysv#parse_path(a:sv_path)
	exe l:edit_command fnameescape(l:infos.whole_path)
endf



"'''''''''''''''''''' function! pysv#complete_sv(lead, line, pos)
function! pysv#complete_sv(lead, line, pos)
	return s:common_complete(v:false, a:lead)
endf

"'''''''''''''''''''' function! pysv#complete_sve(lead, line, pos)
function! pysv#complete_sve(lead, line, pos)
	try
		let l:infos = pysv#parse_path(a:lead)
	catch
		return []
	endtry

	if l:infos.root_path != v:none
		return map(l:infos.files_with_same_prefix, { index, val ->
			\ printf('%s/%s', l:infos.key, strpart(val, l:infos.relative_path_start))
		\ })
	else
		return map(s:common_complete(v:false, a:lead), { index, val ->
			\ printf('%s/', (val))
		\ })
	endif
endf



"'''''''''''''''''''' function! pysv#cv(key, ...)
function! pysv#cv(key, ...)
	call call('s:common_sv', [ v:true, a:key ] + a:000)
endf

"'''''''''''''''''''' function! pysv#complete_cv(lead, line, pos)
function! pysv#complete_cv(lead, line, pos)
	return s:common_complete(v:true, a:lead)
endf

