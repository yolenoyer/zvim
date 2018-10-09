
" TODO: à décommenter:
let s:contacts = v:none


"'''''''''''''''''''' function! huawey#ssh(...)
function! huawey#ssh(...)
	return call('_#system', ['hua-ssh', a:000])
endf

"'''''''''''''''''''' function! huawey#update_contacts()
function! huawey#update_contacts()
	let s:contacts = json_decode(huawey#ssh('termux-contact-list'))
endf

"'''''''''''''''''''' function! huawey#get_contacts()
function! huawey#get_contacts()
	if type(s:contacts) != v:t_list
		call huawey#update_contacts()
	endif
	return s:contacts
endf

"'''''''''''''''''''' function! huawey#search_contact(search)
function! huawey#search_contact(search)
	let l:partial_searches = []
	let l:contacts = huawey#get_contacts()
	let l:uc_search = toupper(a:search)

	for l:contact in l:contacts
		if toupper(l:contact['name']) == l:uc_search
			call insert(l:partial_searches, l:contact, 0)
		elseif match(l:contact['name'], '\c\V' . a:search) != -1
			call add(l:partial_searches, l:contact)
		endif
	endfor

	echo l:partial_searches
endf

