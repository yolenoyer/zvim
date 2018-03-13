
if !has('gui_running')
	finish
endif



" Configuration :

call _#let_default('g:callterm_terminal', 'xterm')
call _#let_default('g:callterm_filebrowser', 'thunar')

call _#let_default('g:callterm_terminals', {})
call extend(g:callterm_terminals, {
	\ 'xterm' : {
	\ 	'cd_argument_template' : '-e "cd \"%s\"; bash"'
	\ },
	\ 'urxvt' : {
	\ 	'cd_argument_template' : '-cd "%s"'
	\ }
\ })



" Plug mappings :

nnoremap <silent> <plug>CalltermTermCurrent :call callterm#call_term("#current#")<cr>
nnoremap <silent> <plug>CalltermTermFile :call callterm#call_term("#file#")<cr>
nnoremap <silent> <plug>CalltermBrowserCurrent :call callterm#call_file_browser("#current#")<cr>
nnoremap <silent> <plug>CalltermBrowserFile :call callterm#call_file_browser("#file#")<cr>


" Normal mappings :

if !exists('g:callterm_nomapping') || !g:callterm_nomapping
	call _#set_mapleader_from_var('g:callterm_mapleader')

	map <leader>T <plug>CalltermTermCurrent
	map <leader>t <plug>CalltermTermFile
	map <leader>B <plug>CalltermBrowserCurrent
	map <leader>b <plug>CalltermBrowserFile

	call _#restore_mapleader()
endif

