

call _#let_default('g:gref_regex_style', 'extended')


" Commandes :
command! -nargs=+ Gref
	\ call gref#gref(<q-args>, g:gref_regex_style)

command! -nargs=+ TGref
	\ call gref#tgref(<q-args>, g:gref_regex_style)

command! -nargs=1 -complete=customlist,gref#regex_style_complete GrefRegexStyle
	\ let g:gref_regex_style = <q-args>


" Abbréviations :
call _#cabbr({
	\ 'gref' : 'Gref',
	\ 'gr'   : 'Gref',
	\ 'tgref': 'TGref',
	\ 'tg'   : 'TGref',
\ })

