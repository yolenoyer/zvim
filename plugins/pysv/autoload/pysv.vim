
"'''''''''''''''''''' function! pysv#get_shortcuts(is_global)
function! pysv#get_shortcuts(is_global)
	let l:command = [ g:pysv_binary, '--list', '--json' ]
	if a:is_global
		let l:command += [ '-L', g:pysv_svinfo_global ]
	else
		let l:command += [ '-C', getcwd() ]
	endif
	let l:output = _#system(l:command)
	if v:shell_error != 0
		throw l:output
	endif
	return json_decode(l:output)
endf



"'''''''''''''''''''' function! pysv#get_path(is_global, key)
function! pysv#get_path(is_global, key)
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

	let l:command = a:0 >= 1 && a:1 == 'l' ? 'lcd' : 'cd'
	let l:path = escape(l:path, ' \')
	let l:command = join([ l:command, l:path ], ' ')

	echo l:command
	exe l:command
endf



"'''''''''''''''''''' function! s:common_complete(is_global, lead)
function! s:common_complete(is_global, lead)
	try
		let l:shortcuts = pysv#get_shortcuts(a:is_global)
	catch
		return []
	endtry
	let l:keys = keys(l:shortcuts)
	return _#filter_completion(l:keys, a:lead)
endf



"'''''''''''''''''''' function! pysv#sv(key, ...)
function! pysv#sv(key, ...)
	call call('s:common_sv', [ v:false, a:key ] + a:000)
endf

"'''''''''''''''''''' function! pysv#complete_sv(lead, line, pos)
function! pysv#complete_sv(lead, line, pos)
	return s:common_complete(v:false, a:lead)
endf



"'''''''''''''''''''' function! pysv#cv(key, ...)
function! pysv#cv(key, ...)
	call call('s:common_sv', [ v:true, a:key ] + a:000)
endf

"'''''''''''''''''''' function! pysv#complete_cv(lead, line, pos)
function! pysv#complete_cv(lead, line, pos)
	return s:common_complete(v:true, a:lead)
endf

