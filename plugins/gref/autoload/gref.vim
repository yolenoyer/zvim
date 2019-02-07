
"'''''''''''''''''''' function! gref#gref(search, ...)
function! gref#gref(search, ...)
	let l:type_opt = '-E'
	if a:0
		if a:1 == 'basic'
			let l:type_opt = '-G'
		elseif a:1 == 'extended'
			let l:type_opt = '-E'
		elseif a:1 == 'fixed'
			let l:type_opt = '-F'
		elseif a:1 == 'perl'
			let l:type_opt = '-P'
		endif
	endif

	call _#set_temp_option('grepprg', 'gref $* -n ' . l:type_opt)

	exe 'grep' shellescape(a:search)

	call _#restore_option('grepprg')
endf


"'''''''''''''''''''' function! gref#regex_style_complete(lead, cmdline, curspos)
function! gref#regex_style_complete(lead, cmdline, curspos)
	return _#filter_completion([ 'basic', 'extended', 'fixed', 'perl' ], a:lead)
endf


"'''''''''''''''''''' function! gref#tgref(...)
function! gref#tgref(...)
	tabnew
	call call('gref#gref', a:000)
endf


"'''''''''''''''''''' function! gref#get_file_list(search, ...)
function! gref#get_file_list(search, ...)
	let l:args = ['gref', '-', a:search, '-l']
	call extend(l:args, a:000)
	return call('_#systemlist', l:args)
endf

