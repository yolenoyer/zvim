
" Initialisation des plugins externes, gérés par Vundle.
"
" Utilisation des variables d'environnement:
"    $ZV   Si cette variable est définie à 'light', alors une grande partie des plugins ne sera pas
"          chargée (voir + bas)
"    $YCM  Cette variable doit être définie à '1' pour que YouCompleteMe soit chargé.


let s:this_dir = fnamemodify(resolve(expand('<sfile>')), ':p:h')

" Vundle :
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()



"'''''''''''''''''''' Plugin Vundle.vim ''''''''''''''''''''
" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
call _#cabbr({
	\ 'pi' : 'PluginInstall'
\})



"'''''''''''''''''''' Plugin ctrlp.vim ''''''''''''''''''''
Plugin 'kien/ctrlp.vim'
let g:ctrlp_cmd='CtrlPMRUFiles'
let g:ctrlp_extensions = ['buffertag', 'tag', 'line']
let g:ctrlp_regexp = 1
let g:ctrlp_prompt_mappings = {
	\ 'ToggleType(1)':        ['<c-f>', '<c-right>'],
	\ 'ToggleType(-1)':       ['<c-b>', '<c-left>'],
	\ 'AcceptSelection("e")': ['<s-cr>', '<F4>', '<2-LeftMouse>'],
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
 \	'mv' : 'Move', 'rm' : 'Delete',
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
		\ ['high', 'low'], ['top', 'bottom'],
		\ ['start', 'end'],
		\ ['col', 'line', 'row'], ['cols', 'lines', 'rows'],
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
	let g:UltiSnipsSnippetsDir = printf('%s/plugins/snippets/ultisnips', s:this_dir)
	let g:UltiSnipsSnippetDirectories=['ultisnips']
	call _#cabbr('es', 'UltiSnipsEdit')

	" Snippets
	" Plugin 'honza/vim-snippets'



	"'''''''''''''''''''' Barre de statut (lightline) ''''''''''''''
	Plugin 'itchyny/lightline.vim'
	let g:lightline = {
	\ 'colorscheme': 'yo',
	\ 'active' : {
	\     'left': [
	\         [ 'gitbranch' ],
	\         [ 'bufnum' ],
	\         [ 'readonly'],
	\         [ 'myfilename', 'modified' ],
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
	\     'cwd' : '[ %{getcwd()} ]',
	\     'myfilename' : '%{LLF_Prepare()}%{b:llf_parts[0]}%#Lightline_Pysv#%{b:llf_parts[1]}%#LightlineLeft_active_3#%{b:llf_parts[2]}',
	\ },
	\ 'component_expand' : {
	\     'gitbranch' : 'fugitive#head',
	\ },
	\ 'component_type' : {
	\     'gitbranch' : 'git',
	\ },
	\}

	function! LLF_Prepare()
		if !exists('b:llf_basic') || b:llf_buffername != @%
			let b:llf_buffername = @%
			let b:llf_basic = fnamemodify(@%, ':p')
			let b:llf_dir_parts = split(fnamemodify(b:llf_basic, ':h'), '/')
			let b:llf_filename = fnamemodify(b:llf_basic, ':t')
			let b:llf_cwd = ''
		endif

		if b:llf_cwd != getcwd()
			let b:llf_cwd = getcwd()

			let b:llf_parts = ['', '', '']

			if @% == ''
				let b:llf_parts[0] = '[Brouillon]'
				return ''
			endif

			let l:cur_part = 0
			let l:construct_path = ''

			for l:dir_part in b:llf_dir_parts
				let l:construct_path .= '/' . l:dir_part
				if l:construct_path == b:llf_cwd
					let b:llf_parts[0] .= '/'
					let b:llf_parts[1] = l:dir_part
					let l:cur_part = 2
				else
					let b:llf_parts[l:cur_part] .= '/' . l:dir_part
				endif
			endfor

			let b:llf_parts[2] .= '/' . b:llf_filename
		endif

		return ''
	endf




	"'''''''''''''''''''' Fugitive ''''''''''''''''''''
	Plugin 'tpope/vim-fugitive'

	"'''''''''''''''''''' GitGutter ''''''''''''''''''''
	Plugin 'airblade/vim-gitgutter'
	let g:gitgutter_map_keys = 0
	nmap <space>hs <Plug>GitGutterStageHunk
	nmap <space>hu <Plug>GitGutterUndoHunk
	nmap <space>hp <Plug>GitGutterPreviewHunk
	nmap [c <Plug>GitGutterPrevHunk
	nmap ]c <Plug>GitGutterNextHunk



    "'''''''''''''''''''' Doxygen ''''''''''''''''''''
    Plugin 'DoxygenToolkit.vim'
	let g:DoxygenToolkit_briefTag_pre = ''

	call _#cabbr('dox', 'call DoxygenYo()')
	call _#cabbr('doxc', 'call DoxygenYo("constructor")')
	function! DoxygenYo(...)
		call _#set_temp_option('indentexpr', '')
		call _#set_temp_option('cindent', 1)
		Dox

		if a:0 >= 1 && a:1 == 'constructor'
			exe "norm AConstructor.\<esc>2j"
			startinsert!
		endif

		call _#restore_option('indentexpr')
		call _#restore_option('cindent')
	endf



	"'''''''''''''''''''' Plugin nerdtree ''''''''''''''''''''
	Plugin 'scrooloose/nerdtree'
	let NERDTreeQuitOnOpen = 1  " Ferme le menu à l'ouverture d'un fichier
	let NERDTreeMapPreview = 'v'
	nnoremap <silent> <space>t :NERDTreeFind<cr>
	nnoremap <silent> <F2>t :NERDTreeToggle<cr>



	"'''''''''''''''''''' Plugin gundo.vim ''''''''''''''''''''
	Plugin 'sjl/gundo.vim'
	nnoremap <silent> _u :GundoToggle<CR>



	"'''''''''''''''''''' Plugin vim-quickrun ''''''''''''''''''''
	Plugin 'thinca/vim-quickrun'
	let g:quickrun_no_default_key_mappings = 1
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
	" Twig :
	Plugin 'lumiliet/vim-twig'
	Plugin 'digitaltoad/vim-pug'
	" Javascript ES7 :
	" Plugin 'othree/yajs.vim'
	" Javascript (syntaxe/indentation): 
	Plugin 'pangloss/vim-javascript'
	Plugin 'leafgarland/typescript-vim'




endif


if $YCM == '1'

	"'''''''''''''''''''' Plugin YouCompleteMe ''''''''''''''''''''
	Plugin 'Valloric/YouCompleteMe'
	exe printf('source %s/youcompleteme.vim', s:this_dir)
	
endif



" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

