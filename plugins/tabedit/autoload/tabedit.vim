
"''''''''''''''''''''     function! tabedit#tabe(flags, ...)
function! tabedit#tabe(flags, ...)
	let l:opts = []
	let l:files = []
	for l:arg in a:000
		if strpart(l:arg, 0, 1) == '+'
			call add(l:opts, l:arg)
		else
			call extend(l:files, expand(l:arg, 0, 1))
		endif
	endfor

	let l:opt_str = len(l:opts) != 0 ? join(l:opts, ' ').' ' : ''

	let l:ins_mode = stridx(a:flags, 'i') != -1
	if l:ins_mode
		let l:com_suffix = ' ' . l:opt_str . '%s'
		let l:com_suffix .= ' | tabm -1 | tabn'
	else
		let l:com_suffix = ' ' . l:opt_str . '%s'
	endif

	let l:ee_mode = stridx(a:flags, 'e') != -1
	if l:ee_mode
		let l:first = v:true
	else
		let l:whole_com = 'tabe' . l:com_suffix
	endif

	for l:file in l:files
		if l:ee_mode && l:first
			let l:whole_com = 'e' . l:com_suffix
		endif
		exe printf(l:whole_com, l:file)
		if l:ee_mode && l:first
			let l:first = v:false
			let l:whole_com = 'tabe' . l:com_suffix
		endif
	endfor

	if l:ins_mode
		tabprev
	endif
endf



"''''''''''''''''''''     function! tabedit#tabn(...)
function! tabedit#tabn(...)
	for l:arg in a:000
		let l:files = expand(l:arg, 0, 1)
		for l:file in l:files
			exe "tabe ".l:file
			w | e

			if &ft == 'vim'
				AutoSource
			endif
		endfor
	endfor
endf

