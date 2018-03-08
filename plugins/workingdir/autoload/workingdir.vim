
"''''''''''''''''''''     function! workingdir#set_from_cur_file(scope)
function! workingdir#set_from_cur_file(scope)
	let s:cmd = a:scope=='local' ? 'lcd' : 'cd'
	let s:new_wd = fnamemodify(@%, ":p:h")
	exe s:cmd  escape(s:new_wd, ' \')
	echo s:new_wd." (".a:scope." pwd)"
endf


