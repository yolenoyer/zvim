
"'''''''''''''''''''' function! sandbox#find_template(filetype)
" Cherche un fichier template pour le type de fichier donné.
function! sandbox#find_template(filetype)
	let l:file_glob = printf('%s/%s.*', g:sandbox_templates_dir, a:filetype)
	let l:files = glob(l:file_glob, 0, 1)
	return empty(l:files) ? v:none : l:files[0]
endf



"'''''''''''''''''''' function! sandbox#sandbox(filetype)
" Ouvre un nouveau buffer d'un certain type, éventuellement rempli avec le contenu d'un template
" associé.
function! sandbox#sandbox(filetype)
	" Création d'un nouveau buffer (mode nowrite = brouillon):
	tabnew
	set bt=nowrite

	" Mappings locaux:
	noremap <silent> <buffer> <F9> :QuickRun<cr>
	inoremap <silent> <buffer> <F9> <c-o>:QuickRun<cr>

	" Recherche d'un template:
	let l:template = sandbox#find_template(a:filetype)
	if l:template != v:none
		" Lecture du template:
		silent! exe "r ".l:template
		" Supprime la 1ère ligne (toujours vide):
		1d_

		" Cherche le mot-clé de placement automatique du curseur:
		call _#set_temp_option('ignorecase', v:true)
		let l:found = search('{{cursor}}', 'cw')
		call _#restore_option('ignorecase')
		if l:found
			d_
		endif
	endif


	" Titre :
	if !empty(a:filetype)
		let &ft = a:filetype
		let l:title = substitute(&ft, '^\w', '\u\0', '') . '\ sandbox'
	else
		let l:title = 'Brouillon'
	endif
	exe 'file' l:title
endf



