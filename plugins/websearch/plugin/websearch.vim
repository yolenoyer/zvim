
"'''''''''''''''''''' Recherche Web

" Plug mappings :

nnoremap <silent> <plug>WebsearchDuckduckgoDev :call websearch#duckduckgoDev(expand('<cword>'))<cr><cr>
vnoremap <silent> <plug>WebsearchDuckduckgoDev <Esc>:call websearch#duckduckgoDev(_#get_visual())<cr><cr>



" Normal mappings :

if !exists('g:websearch_nomapping') || !g:websearch_nomapping
	call _#set_mapleader_from_var('g:websearch_mapleader')

	nmap <leader>S <plug>WebsearchDuckduckgoDev
	vmap <leader>S <plug>WebsearchDuckduckgoDev

	call _#restore_mapleader()
endif

