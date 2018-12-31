
"'''''''''''''''''''' function! B(...)
function! B(...)
	call call(function('buf#buf'), a:000)
endf


noremap! <c-r><c-b> <c-r>=buf#buf()<cr>
noremap! <c-r>B <c-r>=buf#buf('')<left><left>

