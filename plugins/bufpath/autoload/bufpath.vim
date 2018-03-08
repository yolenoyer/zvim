
"''''''''''''''''''''     function! bufpath#fullpath()
" Retourne le chemin complet du buffer courant ou de celui spécifié en argument
function! bufpath#fullpath(...)
	let l:real_buf = a:0 == 0 ? '%' : a:1
	return fnamemodify(buffer_name(l:real_buf), ':p')
endf



"''''''''''''''''''''     function! bufpath#basename()
" Retourne le simple nom de fichier du buffer courant ou de celui spécifié en argument
function! bufpath#basename(...)
	let l:real_buf = a:0 == 0 ? '%' : a:1
	return fnamemodify(buffer_name(l:real_buf), ':t')
endf



"''''''''''''''''''''     function! bufpath#basedir()
" Retourne le répertoire du fichier du buffer courant ou de celui spécifié en argument
function! bufpath#basedir(...)
	let l:real_buf = a:0 == 0 ? '%' : a:1
	return fnamemodify(buffer_name(l:real_buf), ':p:h')
endf



"''''''''''''''''''''     function! RP(buf)
function! bufpath#relativepath(buf)
	let l:target = bufpath#fullpath(a:buf)
	let l:cur_path = bufpath#basedir('%')
	return _#relative_path(l:cur_path, l:target)
endf



