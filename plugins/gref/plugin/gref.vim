
" Commandes :
command! -nargs=+ Gref
	\ call gref#gref(<q-args>)

command! -nargs=+ TGref
	\ call gref#tgref(<q-args>)


" Abbréviations :
call _#cabbr({
	\ 'gref' : 'Gref',
	\ 'gr'   : 'Gref',
	\ 'tgref': 'TGref',
	\ 'tg'   : 'TGref',
\ })

