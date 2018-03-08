
"'''''''''''''''''''' function! callterm#call_term(whichdir)
function! callterm#call_term(whichdir)
	if a:whichdir == '#current#'
		let l:cd_argument = ''
	else
		if a:whichdir == '#file#'
			let l:directory = fnamemodify(@%, ':p:h')
		else
			let l:directory = a:whichdir
		endif

		let l:term_config = g:callterm_terminals[g:callterm_terminal]
		let l:cd_argument_template = l:term_config['cd_argument_template']

		let l:cd_argument = printf(l:cd_argument_template, l:directory)
	endif

	let l:command = printf('!%s %s &', g:callterm_terminal, l:cd_argument)

	echo l:command

	silent exe l:command
endf



"'''''''''''''''''''' function! callterm#call_file_browser(whichdir)
function! callterm#call_file_browser (whichdir)
	if a:whichdir == '#current#'
		silent exe printf('!%s &', g:callterm_filebrowser)
	elseif a:whichdir == '#file#'
		silent exe printf('!%s "%s" &', g:callterm_filebrowser, fnamemodify(@%,":p:h"))
	else
		silent exe printf('!%s "%s" &', g:callterm_filebrowser, a:whichdir)
	endif
endf

