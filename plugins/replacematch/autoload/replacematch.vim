

"'''''''''''''''''''' function! s:strip_pattern_special_chars()
" Supprime grossièrement les caractères spéciaux de pattern
function! s:strip_pattern_special_chars(pattern)
	return substitute(a:pattern, '\v(^|[^\\])\zs(\\.)+', '', 'g')
endf


"'''''''''''''''''''' function! s:leave_command_line()
function! s:leave_command_line()
	let @/ = s:old_search
	call _#restore_option('hls')
	augroup replacematch
		au!
	augroup END
endf


"'''''''''''''''''''' function! replacematch#prefill_s_command(line1, line2, pattern)
" Entre en mode commande et crée une commande `:[range]s/.../.../g` pré-remplie avec le pattern 
" fourni en paramètre, et le texte de substitution correspondant à une version nettoyée de ce 
" pattern (en supprimant grossièrement les caractères spéciaux).
" a:line1 et a:line2 sont utilisés comme range pour la commande.
function! replacematch#prefill_s_command(line1, line2, pattern)
	let s:old_search = @/
	call _#set_temp_option('hls', 1)
	let @/ = a:pattern

	let l:subst = s:strip_pattern_special_chars(a:pattern)

	if a:line1 == 1 && a:line2 == line('$')
		let l:range = '%'
	else
		let l:range = printf('%s,%s', a:line1, a:line2)
	endif

	augroup replacematch
		au!
		au CmdlineLeave * call s:leave_command_line()
	augroup END

	let l:feedkeys =
		\ printf(":keeppatterns %ss/%s/%s/g\<left>\<left>", l:range, a:pattern, l:subst)
	call feedkeys(l:feedkeys, 'n')
endf


