
if (!exists('g:plugman_plugindir'))
	let g:plugman_plugindir = '~/scripts/zvim/plugins'
endif


" Abbréviations :

call _#cabbr({
 \	'pe' : 'MPEdit',
 \	'ep' : 'MPEdit',
 \	'pl' : 'MPList',
 \ })


" Commandes :

command! -nargs=+ -complete=customlist,plugman#complete_edit_command
	\ MPEdit call plugman#edit(<f-args>)

command! -nargs=* -complete=customlist,plugman#complete_list_command
	\ MPList call plugman#list(<f-args>)

