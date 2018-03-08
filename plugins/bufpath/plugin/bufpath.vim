
"'''''''''''''''''''' function! FP(...)
function! FP(...)
	return call('bufpath#fullpath', a:000)
endf

"'''''''''''''''''''' function! BN(...)
function! BN(...)
	return call('bufpath#basename', a:000)
endf

"'''''''''''''''''''' function! BD(...)
function! BD(...)
	return call('bufpath#basedir', a:000)
endf

"'''''''''''''''''''' function! RP(...)
function! RP(...)
	return call('bufpath#relativepath', a:000)
endf

