
let s:this_dir = fnamemodify(resolve(expand('<sfile>')), ':p:h')

" Vundle :
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=/home/io/.vim/bundle/Vundle.vim
call vundle#begin()



"'''''''''''''''''''' Plugin Vundle.vim ''''''''''''''''''''
" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'



"'''''''''''''''''''' Plugin ctrlp.vim ''''''''''''''''''''
Plugin 'kien/ctrlp.vim'
let g:ctrlp_cmd='CtrlPMRUFiles'
let g:ctrlp_extensions = ['buffertag', 'tag', 'line']
let g:ctrlp_regexp = 1
let g:ctrlp_prompt_mappings = {
	\ 'ToggleType(1)':        ['<c-f>', '<c-right>'],
	\ 'ToggleType(-1)':       ['<c-b>', '<c-left>'],
	\ 'AcceptSelection("e")': ['<s-cr>', '<2-LeftMouse>'],
	\ 'AcceptSelection("t")': ['<cr>', '<c-t>'],
    \ }



"'''''''''''''''''''' Plugin vim-surround '''''''''''''
Plugin 'tpope/vim-surround'



"'''''''''''''''''''' Plugin vim-textobj-variable-segment '''''
Plugin 'julian/vim-textobj-variable-segment'
" Dépendance:
Plugin 'kana/vim-textobj-user'



"'''''''''''''''''''' Plugin nerdcommenter ''''''''''''''''''''
Plugin 'scrooloose/nerdcommenter'
let g:NERDSpaceDelims=1
let g:NERDCreateDefaultMappings = 0
map <space>cc <plug>NERDCommenterInvert
map <space>ci <plug>NERDCommenterInvert
map <space>c<space> <plug>NERDCommenterInvert
map <space>cb <plug>NERDCommenterAlignBoth
map <space>cv <plug>NERDCommenterAlignBoth
map <space>cy <plug>NERDCommenterYank
map <space>cu <plug>NERDCommenterUncomment
map <space>cm <plug>NERDCommenterMinimal
map <space>cs <plug>NERDCommenterSexy



"'''''''''''''''''''' Plugin vim-abolish ''''''''''''''''''''
Plugin 'tpope/vim-abolish'



"'''''''''''''''''''' Plugin vim-eunuch ''''''''''''''''''''
" Commandes unix:
Plugin 'tpope/vim-eunuch'
call _#cabbr({
 \	'mv' : 'Move', 'rm' : 'Remove',
 \	'chmod' : 'Chmod', 'chx' : 'Chmod +x',
 \	'ww' : 'SudoWrite',
 \ })



"'''''''''''''''''''' Plugin tabular ''''''''''''''''''''
" alignement de texte:
Plugin 'godlygeek/tabular'
call _#cabbr('ta', 'Tabu')



"'''''''''''''''''''' Plugin vim-cycle ''''''''''''''''''''
" Toggle words:
Plugin 'zef/vim-cycle'
"au VimEnter * call AddMyCycleGroups()

fun! AddMyCycleGroups()
	let l:groups = [
		\ ['True', 'False'], ['yes', 'no'], ['Yes', 'No'],
		\ ['width', 'height'], ['vertical', 'horizontal'],
		\ ['hight', 'low'],
		\ ['col', 'line', 'row'], ['cols', 'lines', 'row'],
		\ ['black', 'white'], ['dark', 'light'],
		\ [ 'blue', 'green', 'orange', 'cyan', 'red', 'purple', 'yellow' ],
        \ ['x', 'y'],
		\]
	for l:group in l:groups
		call AddCycleGroup(l:group)
	endfor
endf



"'''''''''''''''''''' Plugin vim-easyescape ''''''''''''''''''
Plugin 'zhou13/vim-easyescape'
let g:easyescape_chars = { "j": 1, "k": 1 }
let g:easyescape_timeout = 100
cnoremap jk <ESC>
cnoremap kj <ESC>



if $ZV != 'light'

	"'''''''''''''''''''' Snippets '''''''''''''''''''''
	" Moteur
	Plugin 'SirVer/ultisnips'
	let g:UltiSnipsExpandTrigger = '<tab>'
	let g:UltiSnipsJumpForwardTrigger = '<tab>'
	let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
	let g:UltiSnipsListSnippets = '<f1><tab>'
	let g:UltiSnipsEditSplit = 'vertical'
	let g:UltiSnipsSnippetsDir = printf('%s/plugins/snippets/UltiSnips', s:this_dir)
	call _#cabbr('es', 'UltiSnipsEdit')

	" Snippets
	Plugin 'honza/vim-snippets'



	"'''''''''''''''''''' Barre de statut (lightline) ''''''''''''''
	Plugin 'itchyny/lightline.vim'
	let g:lightline = {
	\ 'colorscheme': 'yo',
	\ 'active' : {
	\     'left': [
	\         [ 'gitbranch' ],
	\         [ 'bufnum' ],
	\         [ 'readonly', 'filename', 'modified' ],
	\     ],
	\     'right': [
	\         [ 'col' ],
	\         [ 'line' ],
	\         [ 'fileformat', 'fileencoding', 'percent' ],
	\     ],
	\ },
	\ 'inactive' : {
	\     'left': [
	\         [ 'bufnum' ],
	\         [ 'filename' ],
	\     ],
	\     'right': [
	\         [ 'lineinfo' ],
	\         [ 'percent' ],
	\     ],
	\ },
	\ 'tabline' : {
	\     'left': [ [ 'tabs' ] ],
	\     'right': [ [ 'cwd' ] ],
	\ },
	\ 'tab' : {
	\     'active': [ 'filename', 'modified' ],
	\     'inactive': [ 'filename', 'modified' ],
	\ },
	\ 'component' : {
	\     'percent' : '%P',
	\     'line' : '%3l',
	\     'col' : '%-7(|%c%V|%)',
	\     'cwd' : '%{getcwd()}',
	\ },
	\ 'component_expand' : {
	\     'gitbranch' : 'fugitive#head',
	\ },
	\ 'component_type' : {
	\     'gitbranch' : 'git',
	\ },
	\}



	"'''''''''''''''''''' Git ''''''''''''''''''''
	Plugin 'tpope/vim-fugitive'
	Plugin 'airblade/vim-gitgutter'



	"'''''''''''''''''''' Plugin nerdtree ''''''''''''''''''''
	Plugin 'scrooloose/nerdtree'
	let NERDTreeQuitOnOpen = 1  " Ferme le menu à l'ouverture d'un fichier
	nnoremap <silent> <space>t :NERDTreeFind<cr>
	nnoremap <silent> <F2>t :NERDTreeToggle<cr>



	"'''''''''''''''''''' Plugin gundo.vim ''''''''''''''''''''
	Plugin 'sjl/gundo.vim'
	nnoremap <silent> _u :GundoToggle<CR>



	"'''''''''''''''''''' Plugin vim-quickrun ''''''''''''''''''''
	Plugin 'thinca/vim-quickrun'
	noremap <silent> <space>r :QuickRun<cr>



	"'''''''''''''''''''' Plugin cmdalias.vim ''''''''''''''''''''
	" Alias de commande:
	Plugin 'cmdalias.vim'



	"'''''''''''''''''''' Plugin savemap.vim ''''''''''''''''''''
	" Save mappings:
	Plugin 'tyru/savemap.vim'



	"'''''''''''''''''''' Plugin undo_tags ''''''''''''''''''''
	" Tagger un undo:
	Plugin 'undo_tags'



	"'''''''''''''''''''' Plugin vim-case-convert '''''''''''''''
	" Convertit camelcase -> snake -> hyphen:
	Plugin 'chiedo/vim-case-convert'



	"'''''''''''''''''''' Plugin vim-colorschemes '''''''''''''
	" Des centaines de colorschemes:
	Plugin 'flazz/vim-colorschemes'
	" A conserver (git modifié avec une liste de colorschemes choisis):
	" Plugin 'felixhummel/setcolors.vim'


	"'''''''''''''''''''' Filetypes addons
	Plugin 'lumiliet/vim-twig'
endif



" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

