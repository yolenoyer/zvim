
" Ajoute des fonctionnalités importantes mais non-essentielles.


"'''''''''''''''''''' AutoSource
" Installe une auto-commande qui source le fichier vim actuel à chaque sauvegarde.

command! -bang AutoSource call s:auto_source('<bang>')

call _#cabbr({
\	'as' : 'AutoSource'
\ })

function! s:auto_source(bang)
	augroup autosource
		au!
		if a:bang != '!'
			au BufWritePost <buffer> so %
		endif
	augroup END
	w
endf




"'''''''''''''''''''' SourceThis, SourceThisAlt
" Source la ligne courante, ou le range défini.

command! -range SourceThis call s:source_this(<line1>, <line2>)
command! -range SourceThisAlt call s:source_this_in_alt_buffer(<line1>, <line2>)

call _#cabbr({
\	'st'  : 'SourceThis',
\	'sta' : 'SourceThisAlt',
\ })

function! s:source_this(line1, line2)
	for l:line in getline(a:line1, a:line2)
		exe l:line
	endfor
endf

function! s:source_this_in_alt_buffer(line1, line2)
	let l:lines = getline(a:line1, a:line2)
	buffer #
	for l:line in l:lines
		exe l:line
	endfor
endf




"'''''''''''''''''''' Insérer la date courante

inoremap <c-r><c-d> <c-r>=Date()<cr>
inoremap <c-r><c-t> <c-r>=Time()<cr>
inoremap <c-r><c-a> <c-r>=printf("%s %s", Time(), Date())<cr>

""'''''''''''''''''''' function! Date()
function! Date()
	return strftime('%d/%m/%Y')
endf

""'''''''''''''''''''' function! Date()
function! Time()
	return strftime('%H:%M:%S')
endf




"'''''''''''''''''''' Capture de la sortie des commandes vim

command! -nargs=+ -complete=command TabMessage call Message(<q-args>, 'tab')
command! -nargs=+ -complete=command WinMessage call Message(<q-args>, 'win')

call _#cabbr({
 \	'tm' : 'TabMessage',
 \	'wm' : 'WinMessage',
 \ })

"''''''''''''''''''''     function! Message(cmd, mode)
function! Message(cmd, mode)
	redir => l:message
		silent execute a:cmd
	redir END

	if empty(l:message)
		echo "Aucune sortie"
	else
		exe a:mode == 'tab' ? 'tabnew' : 'new'
		setlocal buftype=nofile bufhidden=wipe noswapfile nobuflisted nomodified
		silent put=l:message
		normal gg"_2ddG
	endif
endfunction




"'''''''''''''''''''' Recherche Web

vnoremap <silent> _w <esc>:call morefeatures#duckduckgo(_#get_visual())<cr><cr>
nnoremap <silent> _w :call morefeatures#duckduckgo(expand('<cword>'))<cr><cr>




