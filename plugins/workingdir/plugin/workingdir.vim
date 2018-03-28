
" Permet de changer le répertoire courant suivant le répertoire du fichier actuel.


noremap <silent> <plug>WorkingdirLocal :call workingdir#set_from_cur_file("local")<cr>
noremap <silent> <plug>WorkingdirGlobal :call workingdir#set_from_cur_file("global")<cr>

if !exists('g:workingdir_nomapping') || !g:workingdir_nomapping
	call _#set_mapleader_from_var('g:workingdir_mapleader')

	map <leader>c <plug>WorkingdirLocal
	map <leader>C <plug>WorkingdirGlobal

	call _#restore_mapleader()
endif

