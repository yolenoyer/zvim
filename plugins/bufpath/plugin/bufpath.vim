
"'''''''''''''''''''' function! FP(...)
" Renvoie le chemin complet du buffer courant ou celui donné en paramètre.
function! FP(...)
	return call('bufpath#fullpath', a:000)
endf

"'''''''''''''''''''' function! BN(...)
" Renvoie le base name du buffer courant ou celui donné en paramètre.
function! BN(...)
	return call('bufpath#basename', a:000)
endf

"'''''''''''''''''''' function! BD(...)
" Renvoie le répertoire de base du buffer courant ou celui donné en paramètre.
function! BD(...)
	return call('bufpath#basedir', a:000)
endf

"'''''''''''''''''''' function! RP(...)
" Renvoie le chemin relatif du buffer désigné par raport au buffer courant.
function! RP(buffer)
	return bufpath#relativepath(a:buffer)
endf

