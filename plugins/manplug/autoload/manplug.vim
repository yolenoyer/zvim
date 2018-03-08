
"'''''''''''''''''''' function! manplug#edit(plugname, ...)
function! manplug#edit(plugname, ...)
	if a:0 == 0
		let l:scripts = manplug#get_plugin_scripts(a:plugname)
	else
		let l:scripts = manplug#get_plugin_scripts(a:plugname, a:1)
	endif
	if type(l:scripts) == v:t_none
		call _#error('manplug', printf('Plugin "%s" non-trouvé', a:plugname))
		return
	endif
	if empty(l:scripts)
		call _#error('manplug', 'Aucun fichier trouvé')
		return
	endif
	for l:script in l:scripts
		exe 'tabe' l:script
	endfor
endf



"'''''''''''''''''''' function! manplug#list_plugin(plugname)
function! manplug#list_plugin(plugname)
	let l:scripts = manplug#get_plugin_scripts(a:plugname)
	if type(l:scripts) == v:t_none
		call _#error('manplug', printf('Plugin "%s" non-trouvé', a:plugname))
		return
	endif
	for l:script in l:scripts
		echo l:script
	endfor
endf



"'''''''''''''''''''' function! manplug#list_plugins()
function! manplug#list_plugins()
	let l:plugins = manplug#get_plugin_list()
	for l:plugin in l:plugins
		echo ''
		let l:script_dirs = manplug#get_plugin_script_dirs(l:plugin)
		echohl Statement
		echon l:plugin
		echohl Normal
		echon ' ('
		let l:first = v:true
		for l:script_dir in l:script_dirs
			if l:first
				let l:first = v:false
			else
				echon ', '
			endif
			echohl Type
			echon l:script_dir
			echohl Normal
		endfor
		echon ')'
	endfor
endf



"'''''''''''''''''''' function! manplug#list(...)
function! manplug#list(...)
	if a:0 == 0
		call manplug#list_plugins()
	else
		call manplug#list_plugin(a:1)
	endif
endf



"'''''''''''''''''''' function! manplug#get_plugin_dir_list()
function! manplug#get_plugin_dir_list()
	let l:glob = g:manplug_plugindir . '/*'
	let l:files = glob(l:glob, 0, 1)
	call filter(l:files, { i, f -> isdirectory(f) })
	return l:files
endf



"'''''''''''''''''''' function! manplug#get_plugin_list(...)
function! manplug#get_plugin_list(...)
	let l:dirs = manplug#get_plugin_dir_list()
	call map(l:dirs, { i, f -> fnamemodify(f, ':t') })
	let l:plugins = l:dirs
	if a:0 > 0
		" Pour la complétion des commandes: filtre seulement les plugins
		" commençant par la chaine indiquée en 1er argument:
		call _#filter_completion(l:plugins, a:1)
	endif
	return l:plugins
endf



"'''''''''''''''''''' function! manplug#get_plugin_dir(plugname)
function! manplug#get_plugin_dir(plugname)
	if a:plugname == v:none
		return g:manplug_plugindir
	endif
	let l:dirs = manplug#get_plugin_dir_list()
	for l:dir in l:dirs
		let l:this_plugname = fnamemodify(l:dir, ':t')
		if l:this_plugname == a:plugname
			return l:dir
		endif
	endfor
	return v:none
endf



"'''''''''''''''''''' function! manplug#get_plugin_scripts(...)
function! manplug#get_plugin_scripts(...)
	if a:0 == 0 || a:1 == '*'
		let l:plugname = v:none
		let l:filter = v:none
	else
		if a:1[0] == '/'
			let l:plugname = v:none
			let l:filter = a:1
		else
			let l:plugname = a:1
			let l:filter = a:0 > 1 ? a:2 : v:none
		endif
	endif

	let l:dir = manplug#get_plugin_dir(l:plugname)
	if l:dir == v:none
		return v:none
	endif
	
	" On détermine le type de filtre suivant les paramètres donnés:
	if l:filter != v:none
		let l:pattern_filter = !empty(l:filter) && l:filter[0] == '/'
		let l:subdir_filter = !l:pattern_filter
	else
		let l:pattern_filter = v:false
		let l:subdir_filter = v:false
	endif
	
	if l:subdir_filter
		" Cherche seulement dans un sous-répertoire éventuel:
		let l:dir = printf('%s/%s', l:dir, l:filter)
	endif
	
	" Cherche les fichiers:
	let l:glob = printf('%s/**/*.vim', l:dir)
	let l:scripts = glob(l:glob, 0, 1)
	
	if l:pattern_filter
		" Filtre les noms de script par un pattern:
		let l:pattern = strpart(l:filter, 1)
		call filter(l:scripts, { i, f -> match(f, l:pattern) != -1 })
	endif
	
	return l:scripts
endf



"'''''''''''''''''''' function! manplug#complete_edit_command(lead, line, pos)
function! manplug#complete_edit_command(lead, line, pos)
	let l:line = strpart(a:line, 0, a:pos)
	let l:args = split(l:line)
	let l:cur_arg = len(l:args)-1
	if l:line[len(l:line)-1] == ' '
		let l:cur_arg += 1
	endif
	if l:cur_arg == 1
		return manplug#get_plugin_list(a:lead)
	elseif l:cur_arg == 2
		let l:lead = len(l:args) >= 3 ? l:args[2] : v:none
		if l:lead != v:none && l:lead[0] == '/'
			return []
		endif
		let l:script_dirs = manplug#get_plugin_script_dirs(l:args[1])
		if l:lead != v:none
			call _#filter_completion(l:script_dirs, l:lead)
		endif
		return l:script_dirs
	endif
	return []
endf



"'''''''''''''''''''' function! manplug#complete_list_command(lead, line, pos)
function! manplug#complete_list_command(lead, line, pos)
	return manplug#get_plugin_list(a:lead)
endf



"'''''''''''''''''''' function! manplug#get_plugin_script_dirs(plugname)
function! manplug#get_plugin_script_dirs(plugname)
	let l:dir = manplug#get_plugin_dir(a:plugname)
	if l:dir == v:none
		return []
	endif
	let l:scripts = manplug#get_plugin_scripts(a:plugname)
	let l:base_dirs = []
	for l:script in l:scripts
		let l:rel_path = strpart(l:script, len(l:dir) + 1)
		let l:path_split = split(l:rel_path, '/')
		if len(l:path_split) <= 1
			continue
		endif
		call add(l:base_dirs, l:path_split[0])
	endfor
	return uniq(sort(l:base_dirs))
endf

