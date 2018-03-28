
"'''''''''''''''''''' function! plugman#edit(plugname, ...)
" Édite un ou plusieurs scripts dans les plugins persos.
" Voir plugman#get_plugin_scripts() pour les paramètres.
function! plugman#edit(plugname, ...)
	if a:0 == 0
		let l:scripts = plugman#get_plugin_scripts(a:plugname)
	else
		let l:scripts = plugman#get_plugin_scripts(a:plugname, a:1)
	endif
	if type(l:scripts) == v:t_none
		call _#error('plugman', printf('Plugin "%s" non-trouvé', a:plugname))
		return
	endif
	if empty(l:scripts)
		call _#error('plugman', 'Aucun fichier trouvé')
		return
	endif

	let l:first = 1
	for l:script in l:scripts
		if l:first
			" Ouvre le 1er buffer dans le buffer courant si celui-ci est vide et nouveau:
			let l:command = _#is_new_buffer() ? 'e' : 'tabe'
			exe l:command l:script
			let l:first = 0
		else
			exe 'tabe' l:script
		endif
	endfor
endf



"'''''''''''''''''''' function! plugman#list_plugin(plugname)
" Affiche la liste des scripts pour un plugin donné.
function! plugman#list_plugin(plugname)
	let l:scripts = plugman#get_plugin_scripts(a:plugname)
	if type(l:scripts) == v:t_none
		call _#error('plugman', printf('Plugin "%s" non-trouvé', a:plugname))
		return
	endif
	for l:script in l:scripts
		echo l:script
	endfor
endf



"'''''''''''''''''''' function! plugman#list_plugins()
" Affiche la liste de tous les plugins, avec les sous-répertoires qu'ils contiennent.
function! plugman#list_plugins()
	let l:plugins = plugman#get_plugins_list()
	for l:plugin in l:plugins
		echo ''
		let l:script_dirs = plugman#get_plugin_script_dirs(l:plugin)
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



"'''''''''''''''''''' function! plugman#list(...)
" Wrapper pour la commande :MPList.
function! plugman#list(...)
	if a:0 == 0
		call plugman#list_plugins()
	else
		call plugman#list_plugin(a:1)
	endif
endf



"'''''''''''''''''''' function! plugman#get_plugins_dir_list()
" Renvoie la liste de tous les répertoires racine des plugins (un par plugin).
function! plugman#get_plugins_dir_list()
	let l:glob = g:plugman_plugindir . '/*'
	let l:files = glob(l:glob, 0, 1)
	call filter(l:files, { i, f -> isdirectory(f) })
	return l:files
endf



"'''''''''''''''''''' function! plugman#get_plugins_list(...)
" Renvoie le nom de tous les plugins, éventuellement filtrée par un leader.
function! plugman#get_plugins_list(...)
	let l:dirs = plugman#get_plugins_dir_list()
	call map(l:dirs, { i, f -> fnamemodify(f, ':t') })
	let l:plugins = l:dirs
	if a:0 > 0
		" Pour la complétion des commandes: filtre seulement les plugins
		" commençant par la chaine indiquée en 1er argument:
		call _#filter_completion(l:plugins, a:1, v:true)
			" v:true = ajoute un espace lorsqu'il n'y a qu'un choix
	endif
	return l:plugins
endf



"'''''''''''''''''''' function! plugman#get_plugin_dir(plugname)
" Renvoie le répertoire racine d'un plugin donné.
function! plugman#get_plugin_dir(plugname)
	if a:plugname == v:none
		return g:plugman_plugindir
	endif
	let l:dirs = plugman#get_plugins_dir_list()
	for l:dir in l:dirs
		let l:this_plugname = fnamemodify(l:dir, ':t')
		if l:this_plugname == a:plugname
			return l:dir
		endif
	endfor
	return v:none
endf



"'''''''''''''''''''' function! plugman#get_plugin_scripts(...)
" Retourne une liste de scripts suivant certains critères.
" Sans paramètre, ou avec a:1="*", renvoie la liste de tous les fichiers
" Le 1er paramètre est soit le nom du plugin dans lequel chercher, soit un '/pattern'.
" Le 2e paramètre est soit le nom d'un dossier du plugin dans lequel chercher, soit un '/pattern'.
function! plugman#get_plugin_scripts(...)
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

	let l:dir = plugman#get_plugin_dir(l:plugname)
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
		if !empty(l:pattern) && l:pattern[len(l:pattern) - 1] == '/'
			" On supprime un '/' final éventuel:
			let l:pattern = strpart(l:pattern, 0, len(l:pattern) - 1)
		endif
		call filter(l:scripts, { i, f -> match(f, l:pattern) != -1 })
	endif

	return l:scripts
endf



"'''''''''''''''''''' function! plugman#complete_edit_command(lead, line, pos)
" Complétion personnalisée pour la commande :MPEdit.
function! plugman#complete_edit_command(lead, line, pos)
	let l:line = strpart(a:line, 0, a:pos)
	let l:args = split(l:line)
	let l:cur_arg = len(l:args)-1
	if l:line[len(l:line)-1] == ' '
		let l:cur_arg += 1
	endif
	if l:cur_arg == 1
		return plugman#get_plugins_list(a:lead)
	elseif l:cur_arg == 2
		let l:lead = len(l:args) >= 3 ? l:args[2] : v:none
		if l:lead != v:none && l:lead[0] == '/'
			return []
		endif
		let l:script_dirs = plugman#get_plugin_script_dirs(l:args[1])
		if l:lead != v:none
			call _#filter_completion(l:script_dirs, l:lead, v:true)
				" v:true = ajoute un espace lorsqu'il n'y a qu'un choix
		endif
		return l:script_dirs
	endif
	return []
endf



"'''''''''''''''''''' function! plugman#complete_list_command(lead, line, pos)
" Complétion personnalisée pour la commande :MPList.
function! plugman#complete_list_command(lead, line, pos)
	return plugman#get_plugins_list(a:lead)
endf



"'''''''''''''''''''' function! plugman#get_plugin_script_dirs(plugname)
" Pour un plugin donné, renvoie la liste des répertoires de 1er niveau contenant des scripts vim.
function! plugman#get_plugin_script_dirs(plugname)
	let l:dir = plugman#get_plugin_dir(a:plugname)
	if l:dir == v:none
		return []
	endif
	let l:scripts = plugman#get_plugin_scripts(a:plugname)
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

