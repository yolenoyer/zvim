
" Configuration :

call _#let_default('g:sandbox_templates_dir', '~/info/templates/sandbox')



" Mappings :

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
	exe printf('nnoremap <silent> ès%s :Sandbox %s<cr>', s:mapping[0], s:mapping[1])
endfor

nnoremap <silent> èss :Sandbox <c-r>=&ft<cr><cr>



" Commandes :

command! -nargs=* -complete=filetype Sandbox call sandbox#sandbox(<q-args>)


