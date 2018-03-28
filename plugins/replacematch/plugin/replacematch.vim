
" Permet de remplacer rapidement le mot sous le curseur, ou la recherche courante, en
" pré-remplissant une command :s// .


" Édite une commande :s pré-complétée avec la recherche courante, pour remplacer
" rapidement cette recherche:
noremap <silent> <plug>ReplacematchCurrent :ReplaceMatch @/<cr>

" Édite une commande :s pré-complétée avec le mot sous le curseur, pour remplacer
" rapidement ce mot:
noremap <silent> <plug>ReplacematchWholeWord :ReplaceMatch printf('\<%s\>', expand('<cword>'))<cr>

" Édite une commande :s pré-complétée avec le mot sous le curseur, pour remplacer
" rapidement ce mot (recherche sans limite de mot):
noremap <silent> <plug>ReplacematchWord :ReplaceMatch expand('<cword>')<cr>


" Cette commande est utile surtout pour les mappings ci-dessus (particulièrement pour l'option
" -range=% , non-reproductible par une fonction à ma connaissance):
command! -nargs=+ -range=% -complete=expression ReplaceMatch 
	\ call replacematch#prefill_s_command(<line1>, <line2>, <args>)

