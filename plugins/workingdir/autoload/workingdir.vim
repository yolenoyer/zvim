
"''''''''''''''''''''     function! workingdir#set_from_cur_file(scope)
" Change le répertoire courant suivant le répertoire du buffer courant.
" @param a:scope  Si =='local', utilise la commande :lcd au lieu de :cd
function! workingdir#set_from_cur_file(scope)
	let s:cmd = a:scope=='local' ? 'lcd' : 'cd'
	let s:new_wd = fnamemodify(@%, ":p:h")
	exe s:cmd  escape(s:new_wd, ' \')
	echo s:new_wd." (".a:scope." pwd)"
endf

