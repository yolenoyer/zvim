
" Taille par défaut des mots de passe générés:
call _#let_default('g:genpassword_size', 12)

" Jeu par défaut des caractères autorisés pour les mots de passe:
call _#let_default('g:genpassword_charset', 'abcdefghijklmnopqrstuvwxyzrABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789')


"'''''''''''''''''''' function! Pwd(...)
" Génère des mots de passe
"   a:1  Taille éventuelle, sinon utilise g:genpassword_size
"   a:2  Jeu de caractères autorisés pour le mot de passe, sinon utilise g:genpassword_charset
function! Pwd(...)
	return call('password#gen', a:000)
endf

