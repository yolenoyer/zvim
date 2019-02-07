
augroup http_conf
	au!
	au BufReadPost /etc/httpd/conf/httpd.conf lcd /etc/httpd
augroup end


" Indentation courte (2 espaces) pour les templates .pug:
" augroup filetype_pug
"     au!
"     au BufReadPost *.pug  setl ts=2 | setl sw=2
" augroup end


" augroup filetype_help
"     au!
"     au FileType help nnoremap <buffer> <cr> <c-]>
" augroup end

