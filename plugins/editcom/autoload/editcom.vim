
"'''''''''''''''''''' function! editcom#get_command(name)
function! editcom#get_command(name)
	return substitute(system('command -v '.shellescape(a:name)),'[\n\r]\+$','','g')
endf

"'''''''''''''''''''' function! editcom#complete (ArgLead, L, P)
function! editcom#complete (ArgLead, L, P)
	return system('listcommands ^'.a:ArgLead)
endf

