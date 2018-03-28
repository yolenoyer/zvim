
" Permet d'ouvrir rapidement un buffer pour un type de fichier particulier, éventuellement complété
" par le contenu d'un template (associé à ce type de fichier)


" Configuration :

call _#let_default('g:sandbox_templates_dir', '~/info/templates/sandbox')



" Plug mappings :

let s:sandbox_mappings = [
	\ [ 'v',  'vim' ],
	\ [ 'py', 'python' ],
	\ [ 'ph', 'php' ],
	\ [ 'b',  'sh' ],
	\ [ 'c',  'c' ],
	\ [ 'C',  'cpp' ],
	\ [ 'x',  'cpp' ],
	\ [ 'l',  'lua' ],
	\ [ 'j',  'javascript' ],
	\ [ 'y',  'yaml' ],
\ ]

for s:mapping in s:sandbox_mappings
	exe printf('nnoremap <silent> <plug>Sandbox%s :Sandbox %s<cr>', _#capitalize(s:mapping[1]), s:mapping[1])
endfor

nnoremap <silent> <plug>SandboxCurrentFT :Sandbox <c-r>=&ft<cr><cr>



" Normal mappings :

if !exists('g:sandbox_nomapping') || !g:sandbox_nomapping
	call _#set_mapleader_from_var('g:sandbox_mapleader')

	for s:mapping in s:sandbox_mappings
		exe printf('map <leader>%s <plug>Sandbox%s', s:mapping[0], _#capitalize(s:mapping[1]))
	endfor

	call _#restore_mapleader()
endif



" Commandes :

command! -nargs=* -complete=filetype Sandbox call sandbox#sandbox(<q-args>)


