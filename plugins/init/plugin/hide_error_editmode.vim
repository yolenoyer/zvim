
augroup hide_error_editmode
	au!
	au VimEnter * let g:error_def = highlight#get_def('Error')
	au InsertEnter * hi Error NONE
	au InsertLeave * call highlight#set_def(g:error_def)
augroup end


