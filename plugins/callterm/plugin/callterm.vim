
" Permet d'appeler un terminal ou un gestionnaire de fichiers dont le chemin de départ est en
" rapport avec le fichier actuel, ou le répertoire courant.



if !has('gui_running')
	finish
endif



" Configuration :

" Chemin vers le terminal à utiliser:
call _#let_default('g:callterm_terminal', 'xterm')

" Chemin vers le gestionnaire de fichiers à utiliser:
call _#let_default('g:callterm_filebrowser', 'thunar')

" Informations spécifiques pour la ligne de commande des terminaux:
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

" Terminal avec le répertoire courant:
nnoremap <silent> <plug>CalltermTermCurrent :call callterm#call_term("#current#")<cr>
" Terminal avec le répertoire contenant le fichier actuel:
nnoremap <silent> <plug>CalltermTermFile :call callterm#call_term("#file#")<cr>
" Gestionnaire de fichiers avec le répertoire courant:
nnoremap <silent> <plug>CalltermBrowserCurrent :call callterm#call_file_browser("#current#")<cr>
" Gestionnaire de fichiers avec le répertoire contenant le fichier actuel:
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

