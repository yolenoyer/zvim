
" Commandes :

command! -nargs=* -complete=file Tabi call tabedit#tabe('i', <f-args>)
command! -nargs=+ -complete=file Tabe call tabedit#tabe('', <f-args>)
command! -nargs=+ -complete=file EE call tabedit#tabe('e', <f-args>)
command! -nargs=+ -complete=file Tabn call tabedit#tabn(<f-args>)



" Abbréviations:

call _#cabbr({
 \	'te' : 'Tabe',
 \	'ti' : 'Tabi',
 \	'e' : 'EE',
 \	'tn' : 'Tabn',
 \ })

