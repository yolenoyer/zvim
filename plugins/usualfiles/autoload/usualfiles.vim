
let s:current_script = expand('<sfile>')


"'''''''''''''''''''' function! usualfiles#open()
function! usualfiles#open()
	call s:open(v:false)
endf



"'''''''''''''''''''' function! usualfiles#tabOpen()
function! usualfiles#tabOpen()
	call s:open(v:true)
endf



"'''''''''''''''''''' function! s:get_usualfiles_file()
function! s:get_usualfiles_file()
	return expand(g:usualfiles_file)
endf



"'''''''''''''''''''' function! s:may_create_usualfiles_file()
function! s:may_create_usualfiles_file()
	let l:usualfiles_file = s:get_usualfiles_file()
	if !filereadable(l:usualfiles_file)
		let l:current_script_dir = fnamemodify(s:current_script, ':p:h')
		let l:template_file = printf('%s/../../template/usualfiles.txt', l:current_script_dir)
		call _#system('cp', l:template_file, l:usualfiles_file)
		if v:shell_error != 0
			throw printf("Le fichier '%s' n'existe pas, et il est impossible de le créer", g:usualfiles_file)
		endif
		return v:true
	endif
	return v:false
endf



"'''''''''''''''''''' function! s:parse_line(line, line_nr)
function! s:parse_line(line, line_nr)
	if match(a:line, '^\s*#\|^\s*$') != -1
		" Commentaire ou ligne vide:
		return {}
	endif
	let l:matches = matchlist(a:line, '\v^\s*([a-zA-Z0-9:]+)\t+([^\t]*)')
	if empty(l:matches)
		call _#error('usualfiles', printf("Ligne %i invalide", a:line_nr))
		return {}
	endif
	return {
	\	'mapping' : l:matches[1],
	\	'target_file' : l:matches[2],
	\ }
endf



"'''''''''''''''''''' function! s:parse_buffer()
function! s:parse_buffer()
	let l:line_nr = 0
	let b:usualfiles_mappings = {}
	for l:line in getbufline('%', 1, '$')
		let l:line_nr += 1
		let l:parse = s:parse_line(l:line, l:line_nr)
		if !empty(l:parse)
			let b:usualfiles_mappings[l:parse['mapping']] = l:parse['target_file']
		endif
	endfor
endf



"'''''''''''''''''''' function! s:process_mapping(mapping)
function! s:process_mapping(mapping)
	let l:usualfiles_buffer = bufnr('%')
	let l:target_file = b:usualfiles_mappings[a:mapping]
	exe 'e' escape(l:target_file, ' \')
	exe 'bw' l:usualfiles_buffer
endf



"'''''''''''''''''''' function! s:process_current_line()
function! s:process_current_line()
	let l:parse = s:parse_line(getline('.'), line('.'))
	if !empty(l:parse)
		call s:process_mapping(l:parse['mapping'])
	endif
endf



"'''''''''''''''''''' function! s:install_mappings()
function! s:install_mappings()
	if b:usualfiles_is_mapped
		call s:uninstall_mappings()
	endif

	call s:parse_buffer()
	
	for l:mapping in keys(b:usualfiles_mappings)
		let l:mapping_str = printf('"%s"', escape(l:mapping, '"\'))
		let l:command = printf(':call <sid>process_mapping(%s)<cr>', l:mapping_str)
		exe 'nnoremap <silent> <buffer> <nowait>' l:mapping l:command
	endfor
	let b:usualfiles_is_mapped = v:true
endf



"'''''''''''''''''''' function! s:update_mappings()
function! s:update_mappings()
	if b:usualfiles_is_mapped
		call s:install_mappings()
	endif
endf



"'''''''''''''''''''' function! s:uninstall_mappings()
function! s:uninstall_mappings()
	if b:usualfiles_is_mapped == v:false
		return
	endif
	for l:mapping in keys(b:usualfiles_mappings)
		exe 'nunmap <buffer>' l:mapping
	endfor
	let b:usualfiles_is_mapped = v:false
endf



"'''''''''''''''''''' function! s:toggle_mappings()
function! s:toggle_mappings()
	if b:usualfiles_is_mapped
		call s:uninstall_mappings()
		echo "Les mappings locaux ont été supprimés"
	else
		call s:install_mappings()
		echo "Les mappings locaux ont été installés"
	endif
endf



"'''''''''''''''''''' function! s:close_buffer()
function! s:close_buffer()
	let l:usualfiles_buffer = bufnr('%')
	if !b:usualfiles_is_tab
		b #
	endif
	exe 'bw' l:usualfiles_buffer
endf



"'''''''''''''''''''' function! s:open(tab)
function! s:open(tab)
	try
		" Création éventuelle du fichier menu:
		call s:may_create_usualfiles_file()

		" Création d'un nouveau buffer:
		let l:edit = a:tab ? 'tabe' : 'e'
		exe l:edit escape(g:usualfiles_file, ' \')

		" Configuration du nouveau buffer:
		let b:usualfiles_is_mapped = v:false
		let b:usualfiles_is_tab = a:tab

		" Mapping locaux:
		call s:install_mappings()
		nnoremap <buffer> <silent> <nowait> <space>m :call <sid>toggle_mappings()<cr>
		nnoremap <buffer> <silent> <nowait> <f11> :call <sid>close_buffer()<cr>
		if has('gui_running')
			nnoremap <buffer> <silent> <nowait> <esc> :call <sid>close_buffer()<cr>
		endif
		nnoremap <buffer> <silent> <nowait> <cr> :call <sid>process_current_line()<cr>
		" Actualisation des mappings en cas de sauvegarde du fichier:
		au BufWritePost <buffer> call s:update_mappings()
		" Position du curseur;
		if g:usualfiles_resetCursorPos
			call cursor(1, 1)
		endif
		" Divers
		setlocal nobuflisted
	catch
		call _#error('usualfiles', v:exception)
	endtry
endf

