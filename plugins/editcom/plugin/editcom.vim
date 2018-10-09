
" Permet d'ouvrir rapidement un script exécutable contenu dans le $PATH système, en précisant
" simplement son nom (complétion activée).


" Mappings:
map <plug>EditcomTabEdit :Tecom <c-r><c-f><cr>
map <plug>EditcomEdit    :Ecom <c-r><c-f><cr>


" Commandes:
command! -nargs=1 -complete=custom,editcom#complete Tecom
	\ exe 'tabe' editcom#get_command(<q-args>)
command! -nargs=1 -complete=custom,editcom#complete Ecom
	\ exe 'e'    editcom#get_command(<q-args>)


" Abbréviations:
call _#cabbr({
	\ 'tecom' : 'Tecom',
	\ 'ecom'  : 'Ecom',
\})

