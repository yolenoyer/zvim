
"'''''''''''''''''''' function! B(...)
function! B(...)
	return call(function('buf#buf'), a:000)
endf

"'''''''''''''''''''' function! B(...)
function! BL(...)
	return call(function('buf#buflist'), a:000)
endf


noremap! <c-r><c-b> <c-r>=buf#buf()<cr>
noremap! <c-r>B <c-r>=buf#buf('')<left><left>

