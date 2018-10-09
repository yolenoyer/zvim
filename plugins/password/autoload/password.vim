
"'''''''''''''''''''' function! password#gen(...)
" Génère des mots de passe
"   a:1  Taille éventuelle, sinon utilise g:genpassword_size
"   a:2  Jeu de caractères autorisés pour le mot de passe, sinon utilise g:genpassword_charset
function! password#gen(...)
	let l:size = a:0>=1 ? a:1 : g:genpassword_size
	let l:charset = a:0>=2 ? a:2 : g:genpassword_charset

	let l:password = ''

	py3 <<
import secrets
import vim

l = vim.bindeval('l:')
password = ''
charset = l['charset'].decode('utf-8')

for i in range(l['size']):
	n = secrets.randbelow(len(charset))
	password += charset[n]

l['password'] = password
.

	return l:password
endf

