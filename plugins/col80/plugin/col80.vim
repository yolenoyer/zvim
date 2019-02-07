
call _#let_default('g:col80_state', 0)
call _#let_default('g:col80_column', 80)
call _#let_default('g:col80_enable_mappings', 1)



if g:col80_state
	call col80#on()
endif



command! -nargs=? Col80Toggle call col80#toggle(<f-args>)
command! -nargs=? Col80On call col80#on(<f-args>)
command! -nargs=? Col80Off call col80#off(<f-args>)
command! -nargs=1 Col80SetColum call col80#set_column(<f-args>)



noremap <silent> <Plug>Col80SetColOrToggle :<c-u>call col80#setcol_or_toggle(v:count)<cr>
noremap <silent> <Plug>Col80SetCurrentCol :<c-u>call col80#set_current_col()<cr>

