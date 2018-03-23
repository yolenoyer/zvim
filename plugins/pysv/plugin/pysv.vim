
" Configuration :

call _#let_default('g:pysv_svinfo_global', '~/.svinfo.global')
call _#let_default('g:pysv_binary', '/usr/local/bin/pysv')




" Commandes :

command! -nargs=1 -complete=customlist,pysv#complete_cv
 \	Cv call pysv#cv(<q-args>)

command! -nargs=1 -complete=customlist,pysv#complete_cv
 \	Lcv call pysv#cv(<q-args>, 'l')

command! -nargs=1 -complete=customlist,pysv#complete_sv
 \	Sv call pysv#sv(<q-args>)

command! -nargs=1 -complete=customlist,pysv#complete_sve
 \	Sve call pysv#sve(<q-args>)

command! -nargs=1 -complete=customlist,pysv#complete_sve
 \	Svte call pysv#sve(<q-args>, v:true)

command! -nargs=1 -complete=customlist,pysv#complete_sv
 \	Lsv call pysv#sv(<q-args>, 'l')



" Abbréviations :

call _#cabbr({
 \	'cv'   : 'Cv',
 \	'lcv'  : 'Lcv',
 \	'sv'   : 'Sv',
 \	'sve'  : 'Sve',
 \	'svte' : 'Svte',
 \	'lsv'  : 'Lsv',
 \ })

