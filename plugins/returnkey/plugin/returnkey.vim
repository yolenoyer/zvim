
noremap  <silent> <f1><cr>      :call returnkey#set_mode('toggle', 1)<cr>
inoremap <silent> <f1><cr> <c-o>:call returnkey#set_mode('toggle', 1)<cr>

if exists('g:returnkey_mode') && g:returnkey_mode == 'on'
	call returnkey#set_mode('on', 0)
endif

