
"'''''''''''''''''''' Petites modifications

" Séparer une ligne en deux
noremap go i<cr><esc>

" Insérer une ligne avant / après
noremap <silent> _O :call append(line('.')-1, '')<cr>
noremap <silent> _o :call append(line('.'), '')<cr>

" Supprimer tout le contenu d'une ligne
nnoremap dD 0D
nnoremap dp ddp
nnoremap dP ddkP




"'''''''''''''''''''' Remplacements de texte

" Supprime tous les espaces en fin de ligne dans le buffer en cours:
nnoremap <silent> _<space> :%s/\s\+$//<cr>




"'''''''''''''''''''' Complétion

inoremap <c-f> <c-x><c-f>
inoremap <c-l> <c-x><c-l>
inoremap <c-b> <c-x><c-p>




"'''''''''''''''''''' Dupliquer une ligne (edit mode)

" inoremap <c-_> <esc>:t+0<cr>gi<c-o>j




