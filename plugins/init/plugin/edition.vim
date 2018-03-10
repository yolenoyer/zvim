
"'''''''''''''''''''' Petites modifications

" Séparer une ligne en deux
noremap go i<cr><esc>

" Supprimer tout le contenu d'une ligne
nnoremap dD 0D
nnoremap dp ddp
nnoremap dP ddkP




"'''''''''''''''''''' Remplacements de texte

" Édite une commande :s pré-complétée avec la recherche courante, pour remplacer 
" rapidement cette recherche:
noremap _rr :call <sid>replace_match(@/)<cr>

" Édite une commande :s pré-complétée avec le mot sous le curseur, pour remplacer 
" rapidement ce mot:
noremap _rw :call <sid>replace_match("\\<<c-r><c-w>\\>")<cr>

" Édite une commande :s pré-complétée avec le mot sous le curseur, pour remplacer 
" rapidement ce mot (recherche sans limite de mot):
noremap _rW :call <sid>replace_match("<c-r><c-w>")<cr>

"''''''''''''''''''''     function! s:replace_match()
function! s:replace_match(pattern)
	let @/ = a:pattern
	set hls

	let l:subst = a:pattern
	if match(l:subst, '^\\<') != -1
		let l:subst = strpart(l:subst, 2)
	endif
	if match(l:subst, '\\>$') != -1
		let l:subst = strpart(l:subst, 0, len(l:subst) - 2)
	endif

	call feedkeys(printf(":%%s/%s/%s/g\<left>\<left>", a:pattern, l:subst), 'n')
endf


" Supprime tous les espaces en fin de ligne dans le buffer en cours:
nnoremap <silent> è<space> :%s/\s\+$//




"'''''''''''''''''''' Complétion

inoremap <c-]> <c-x><c-]>
inoremap <c-f> <c-x><c-f>
inoremap <c-l> <c-x><c-l>
inoremap <c-b> <c-x><c-p>




