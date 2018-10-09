

" TODO: à nettoyer


"''''''''''''''''''''     function! syntools#get_highlight_id()
function! syntools#get_highlight_id()
" Retourne le highlight id de base du caractère sous le cursur
	return synID(line('.'), col('.'), 1)
endf


"''''''''''''''''''''     function! syntools#get_base_highlight_id()
function! syntools#get_base_highlight_id()
" Retourne le highlight id de base du caractère sous le cursur
	return synIDtrans(synID(line('.'), col('.'), 1))
endf


"''''''''''''''''''''     function! syntools#get_highlight_name()
function! syntools#get_highlight_name()
	return synIDattr(synID(line('.'), col('.'), 1), 'name')
endf


"''''''''''''''''''''     function! syntools#get_base_highlight_name()
function! syntools#get_base_highlight_name()
	return synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
endf


"''''''''''''''''''''     function! syntools#get_highlight_func_name(base_mode, id_mode)
function! syntools#get_highlight_func_name(base_mode, id_mode)
	if !a:base_mode && !a:id_mode | return 'syntools#get_highlight_name'
	elseif !a:base_mode && a:id_mode | return 'syntools#get_highlight_id'
	elseif a:base_mode && !a:id_mode | return 'syntools#get_base_highlight_name'
	elseif a:base_mode && a:id_mode | return 'syntools#get_base_highlight_id'
	endif
endf


"''''''''''''''''''''     function! syntools#enable_auto_show_highlight()
function! syntools#enable_auto_show_highlight()
	echo synIDattr(synID(line('.'), col('.'), 1), 'name')
	augroup SynToolsShowHL
		au!
		au CursorMoved * echo synIDattr(synID(line('.'), col('.'), 1), 'name')
	augroup END	
endf


"''''''''''''''''''''     function! syntools#disable_auto_show_highlight()
function! syntools#disable_auto_show_highlight()
	au! SynToolsShowHL
endf


"''''''''''''''''''''     function! syntools#toggle_auto_show_highlight()
function! syntools#toggle_auto_show_highlight()
	if !exists('g:highlight_show_enable')
		let g:highlight_show_enable = 0
	endif
	let g:highlight_show_enable = !g:highlight_show_enable
	if g:highlight_show_enable
		call syntools#enable_auto_show_highlight()
	else
		call syntools#disable_auto_show_highlight()
		echo "Highlight group désactivé"
	endif
endf


"''''''''''''''''''''     function! syntools#clear_highlight()
" Supprime le highlight actuellement sous le curseur (":syn on" pour 
" réinitialiser):
function! syntools#clear_highlight()
	let name = synIDattr(synID(line('.'), col('.'), 1), 'name')
	exe "hi clear " . name
	exe "hi link " . name . " NONE"
endf


"''''''''''''''''''''     function! syntools#disp_highlight(flags)
function! syntools#disp_highlight(flags)
	let auto_mode = 0
	let base_mode = 0
	let id_mode = 0
	let mode = 'name'
	let flags = split(a:flags)
	for f in flags
		if f == 'auto' | let auto_mode = 1 | endif
		if f == 'base' | let base_mode = 1 | endif
		if f == 'id' | let id_mode = 1 | endif
		if f == 'stop'
			call s:auto_disp_highlight_name(0, 0, 0)
			return
		endif
	endfor

	if auto_mode
		call s:auto_disp_highlight_name(1, base_mode, id_mode)
	else
		exe "echo " . syntools#get_highlight_func_name(base_mode, id_mode) . "()"
	endif
endf




"''''''''''''''''''''     function! s:auto_disp_highlight_name(new_status, base_mode, id_mode)
function! s:auto_disp_highlight_name(new_status, base_mode, id_mode)
	augroup AutoDispHL
		au!
		if !a:new_status | return | endif

		exe "au CursorMoved * echo " . syntools#get_highlight_func_name(a:base_mode, a:id_mode) . "()"
	augroup END
endf


