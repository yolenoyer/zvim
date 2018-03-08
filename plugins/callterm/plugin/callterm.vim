
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



" Mappings :

nnoremap <silent> èT :call callterm#call_term("#current#")<cr>
nnoremap <silent> èt :call callterm#call_term("#file#")<cr>
nnoremap <silent> èB :call callterm#call_file_browser("#current#")<cr>
nnoremap <silent> èb :call callterm#call_file_browser("#file#")<cr>



