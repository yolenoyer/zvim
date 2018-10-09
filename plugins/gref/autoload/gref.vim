
"'''''''''''''''''''' function! gref#gref(search)
function! gref#gref(search)
	call _#set_temp_option('grepprg', 'gref $* -n')

	exe 'grep' shellescape(a:search)

	call _#restore_option('grepprg')
endf


"'''''''''''''''''''' function! gref#tgref(search)
function! gref#tgref(search)
	tabnew
	call gref#gref(a:search)
endf


"'''''''''''''''''''' function! gref#get_file_list(search, ...)
function! gref#get_file_list(search, ...)
	let l:args = ['gref', a:search, '-l']
	call extend(l:args, a:000)
	return call('_#systemlist', l:args)
endf

