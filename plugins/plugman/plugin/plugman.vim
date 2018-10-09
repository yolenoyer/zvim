
" Permet de gérer les plugins persos (listing, commande d'édition de fichier avec complétion
" avancée).



if (!exists('g:plugman_plugindir'))
	let g:plugman_plugindir = '~/scripts/zvim/plugins'
endif


" Abbréviations :

call _#cabbr({
 \	'pe' : 'PEdit',
 \	'ep' : 'PEdit',
 \	'pl' : 'PList',
 \ })


" Commandes :

command! -nargs=+ -complete=customlist,plugman#complete_edit_command
	\ PEdit call plugman#edit(<f-args>)

command! -nargs=* -complete=customlist,plugman#complete_list_command
	\ PList call plugman#list(<f-args>)

