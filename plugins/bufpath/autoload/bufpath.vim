
"'''''''''''''''''''' function! bufpath#fullpath()
" Retourne le chemin complet du buffer courant ou de celui spécifié en argument
function! bufpath#fullpath(...)
	let l:real_buf = a:0 == 0 ? '%' : a:1
	return fnamemodify(bufname(l:real_buf), ':p')
endf



"'''''''''''''''''''' function! bufpath#basename()
" Retourne le simple nom de fichier du buffer courant ou de celui spécifié en argument
function! bufpath#basename(...)
	let l:real_buf = a:0 == 0 ? '%' : a:1
	return fnamemodify(bufname(l:real_buf), ':t')
endf



"'''''''''''''''''''' function! bufpath#basedir()
" Retourne le répertoire du fichier du buffer courant ou de celui spécifié en argument
function! bufpath#basedir(...)
	let l:real_buf = a:0 == 0 ? '%' : a:1
	return fnamemodify(bufname(l:real_buf), ':p:h')
endf



"'''''''''''''''''''' function! bufpath#relativepath(buf)
" Retourne le chemin relatif vers le fichier édité dans le buffer a:buf, par rapport au buffer
" courant.
" @param a:buf  Buffer spécifié par son numéro, une partie de son nom... (cf :h bufname() )
function! bufpath#relativepath(buf)
	let l:target = bufpath#fullpath(a:buf)
	let l:cur_path = bufpath#basedir('%')
	return _#relative_path(l:cur_path, l:target)
endf



