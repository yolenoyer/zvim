
"'''''''''''''''''''' Inversions . / ; / , / ?

noremap . ;
noremap ; .
noremap ? ,
noremap g? ?
noremap g/ ?
noremap <space>? ?




"'''''''''''''''''''' Pastes

nnoremap gp ]p
nnoremap gP ]P




"'''''''''''''''''''' Yanks

nnoremap yp Yp




"'''''''''''''''''''' Macros

noremap à @a
noremap m: @:




"'''''''''''''''''''' Déplacements curseur

noremap <silent> <Down> gj
noremap <silent> <Up> gk
inoremap <silent> <Down> <c-o>gj
inoremap <silent> <Up> <c-o>gk

noremap ç ^
noremap <home> ^
noremap <kHome> ^

if has('gui_running')
	noremap <kEnter> G
else
	noremap <cr> G
endif

noremap <m-e> ge
noremap <m-E> gE

noremap ) ']
noremap ( '[

noremap <space>; f<space>
noremap <space>, f<space>,




"'''''''''''''''''''' Buffers

noremap <F4><F4> <c-^>




"'''''''''''''''''''' Arguments

noremap <silent> <f5> :previous<cr>
noremap <silent> <f6> :next<cr>




"'''''''''''''''''''' Quickfix

noremap <silent> <f7> :cprevious<cr>zz
noremap <silent> <f8> :cnext<cr>zz




"'''''''''''''''''''' Tabs

noremap <silent> <f9> :tabprevious<cr>
noremap <silent> <f10> :tabnext<cr>
noremap <silent> <c-f9> :tabm -1<cr>
noremap <silent> <c-f10> :tabm +1<cr>




"'''''''''''''''''''' Défilement de la vue

" Faire défiler en laissant le curseur en place
noremap <silent> <S-Down> <c-e>j
noremap <silent> <S-Up> <c-y>k
inoremap <silent> <S-Down> <c-x><c-e><Down>
inoremap <silent> <S-Up> <c-x><c-y><Up>

" Mouvements de molette souris accélérés 
noremap <ScrollWheelUp> 6<c-y>
noremap <ScrollWheelDown> 6<c-e>
inoremap <ScrollWheelUp> <c-o>6<c-y>
inoremap <ScrollWheelDown> <c-o>6<c-e>

" Défilements +/-
noremap <silent> <kMinus> 3<c-u>
noremap <silent> <kPlus> 3<c-d>
noremap <silent> - 3<c-u>
noremap <silent> + 3<c-d>
noremap <silent> <C-kPlus> 4<c-e>
noremap <silent> <C-kMinus> 4<c-y>




"'''''''''''''''''''' Recherche, highlight search

"''''''''''''''''''''     Highlight search
noremap <silent> Q :set nohls<cr>
noremap <silent> _h :set hlsearch!\|set hls?<cr>

"''''''''''''''''''''     Chercher un mot
" Avec limite de mot:
noremap <silent> <m-*> :let @/="\\<lt><c-r><c-w>\\>"\|set hls<cr>
noremap <silent> g* :let @/="\\<lt><c-r><c-w>\\>"\|set hls<cr>
" Sans limite de mot:
noremap <silent> z* :let @/="<c-r><c-w>"\|set hls<cr>

"''''''''''''''''''''     Recherche centrée:
noremap * *zz
noremap <kMultiply> *zz
noremap n nzz
noremap N Nzz




"'''''''''''''''''''' Sélection

noremap gb :norm! '[V']<cr>

"'''''''''''''''''''' Sélection souris

" Visual line select avec <s-leftmouse>:
noremap <s-leftmouse> <3-leftmouse>
noremap <s-leftdrag>  <3-leftdrag>

" Visual line select avec <rightmouse>:
noremap <rightmouse> <3-leftmouse>
noremap <rightdrag>  <3-leftdrag>

" Visual block select avec <c-leftmouse>:
noremap <c-leftmouse> <4-leftmouse>
noremap <c-leftdrag>  <4-leftdrag>




"'''''''''''''''''''' Sauvegarder / Quitter

nnoremap <c-s> :w<cr>
nnoremap ZS :w<cr>
nnoremap <c-z><c-q> :qa!<cr>
nnoremap <c-q><c-q> :qa<cr>
nnoremap <c-q><c-w> :wqa<cr>
nnoremap <c-w><c-q> :wqa<cr>




"'''''''''''''''''''' Désactivation de l'aide avec <F1>

map <f1> <nop>
imap <f1> <lt>F1>




"'''''''''''''''''''' Toggle d'options globales

noremap <silent> <F1>m :call _#toggle_option('mouse', ['a', ''], v:true)<cr>

