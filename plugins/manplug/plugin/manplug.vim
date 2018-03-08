
if (!exists('g:manplug_plugindir'))
	let g:manplug_plugindir = '~/scripts/zvim/plugins'
endif


" Abbréviations :

call _#cabbr({
 \	'pe' : 'MPEdit',
 \	'ep' : 'MPEdit',
 \	'pl' : 'MPList',
 \ })


" Commandes :

command! -nargs=+ -complete=customlist,manplug#complete_edit_command
	\ MPEdit call manplug#edit(<f-args>)

command! -nargs=* -complete=customlist,manplug#complete_list_command
	\ MPList call manplug#list(<f-args>)

