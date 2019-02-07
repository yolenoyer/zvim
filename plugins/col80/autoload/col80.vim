

"'''''''''''''''''''' function! col80#set_column(new_col)
function! col80#set_column(new_col)
	let state_on = _#exists_eq('w:col80_state', 1)

	if state_on && exists('w:col80_column')
		call s:remove_colorcolumn(w:col80_column)
	endif

	let w:col80_column = a:new_col

	if state_on
		call s:add_colorcolumn(w:col80_column)
	endif

	" echo 'Nouvelle colonne:' w:col80_column
endf


"'''''''''''''''''''' function! col80#set_state(new_state)
function! col80#set_state(new_state)
	call s:create_win_defaults()

	if w:col80_state == a:new_state
		return
	endif

	let w:col80_state = a:new_state

	if w:col80_state
		call s:add_colorcolumn(w:col80_column)
	else
		call s:remove_colorcolumn(w:col80_column)
	endif

	" echo 'Nouvel état:' a:new_state
endf


"'''''''''''''''''''' function! col80#set(new_state, ...)
function! col80#set(new_state, ...)
	if a:0 > 0 && a:1 != 0
		call col80#set_column(a:1)
	endif
	call col80#set_state(a:new_state)
endf


"'''''''''''''''''''' function! col80#on(...)
function! col80#on(...)
	let args = [ 1 ]
	call extend(args, a:000)
	call call('col80#set', args)
endf


"'''''''''''''''''''' function! col80#off(...)
function! col80#off(...)
	let args = [ 0 ]
	call extend(args, a:000)
	call call('col80#set', args)
endf


"'''''''''''''''''''' function! col80#toggle()
function! col80#toggle()
	call s:create_win_defaults()
	call col80#set_state(!w:col80_state)
endf


"'''''''''''''''''''' function! col80#setcol_or_toggle(...)
function! col80#setcol_or_toggle(...)
	if a:0 > 0 && a:1 != 0
		call col80#set_column(a:1)
		call col80#on()
	else
		call col80#toggle()
	endif
endf


"'''''''''''''''''''' function! col80#set_current_col()
function! col80#set_current_col()
	let cur_col = v:count != 0 ? v:count : virtcol('.')
	if _#exists_eq('w:col80_state', 1) && cur_col == w:col80_column
		call col80#off()
	else
		call col80#on(cur_col)
	endif
endf



"##################### Private functions: #####################


"'''''''''''''''''''' function! s:add_colorcolumn(col)
function! s:add_colorcolumn(col)
	exe printf('set colorcolumn+=%i', a:col)
endf


"'''''''''''''''''''' function! s:remove_colorcolumn(col)
function! s:remove_colorcolumn(col)
	exe printf('set colorcolumn-=%i', a:col)
endf


"'''''''''''''''''''' function! s:move_colorcolumn(from, to)
function! s:move_colorcolumn(from, to)
	call s:remove_colorcolumn(a:from)
	call s:add_colorcolumn(a:to)
endf


"'''''''''''''''''''' function! s:create_win_defaults()
function! s:create_win_defaults()
	call _#let_default('w:col80_column', 80)
	call _#let_default('w:col80_state', 0)
endf


"'''''''''''''''''''' function! s:unlet_win_vars()
function! s:unlet_win_vars()
	unlet! w:col80_column  w:col80_state
endf

