
" Entre deux espaces:
onoremap i<space> :<c-u>normal! T<space>vt<space><cr>
xnoremap i<space> T<space>ot<space>

" Buffer complet:
onoremap if :<c-u>normal! VggoG<cr>
xnoremap if ggoG

" Ligne complète sans les espaces extérieurs:
onoremap ii :<c-u>normal! v^og_<cr>
xnoremap ii ^og_

" Ligne complète sans le retour chariot:
onoremap ai :<c-u>normal! v0o$h<cr>
xnoremap ai 0o$h

" Motion entre deux caractères demandés intéractivement:
onoremap I? :<c-u>call init#get_motions_chars(0)<cr>
onoremap A? :<c-u>call init#get_motions_chars(1)<cr>

