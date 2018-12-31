
" Indentation courte (2 espaces) pour les templates .pug:
augroup pug_indent
	au!
	au BufReadPost *.pug  setl ts=2 | setl sw=2
augroup end


augroup http_conf
	au!
	au BufReadPost /etc/httpd/conf/httpd.conf lcd /etc/httpd
augroup end

