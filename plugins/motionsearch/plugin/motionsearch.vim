
" Mappings :
nnoremap <silent> <plug>MotionsearchSearch :call motionsearch#set_opfunc()<cr>g@
nnoremap <silent> <plug>MotionsearchSearchNomove :call motionsearch#set_opfunc_nomove()<cr>g@
vnoremap <silent> <plug>MotionsearchSearchNomove <esc>:let @/ = _#get_visual()<cr>

