
call _#let_default('g:colorscheme_default', 'gruvbox')


let s:schemes = [ 'gruvbox', 'desert' ]


command! -nargs=? -complete=customlist,colorscheme#handle_completion
 \ ColorScheme
 \ call colorscheme#set(<f-args>)



"'''''''''''''''''''' function! colorscheme#set(...)
function! colorscheme#set(...)
	let scheme = a:0>0 ? a:1 : g:colorscheme_default
	call call('colorscheme#'.scheme, [])
	if exists(':LightlineColorscheme')
		LightlineColorscheme
	endif
endf


"'''''''''''''''''''' function! colorscheme#gruvbox()
function! colorscheme#gruvbox()
	set background=dark
	colorscheme gruvbox
	hi Normal ctermbg=232 guibg=black
	hi CursorLine ctermbg=234 guibg=#202020 gui=NONE
	hi SignColumn ctermbg=234
	hi Visual ctermbg=238 cterm=NONE term=NONE gui=NONE guibg=#303030
	hi Search ctermbg=240 ctermfg=yellow cterm=bold term=bold
	hi CursorLineNr ctermbg=NONE guibg=NONE

	hi link jsOperatorKeyword Statement

	hi link cssTextProp cssProp
	hi link cssAnimationProp cssProp
	hi link cssUIProp cssProp
	hi link cssTransformProp cssProp
	hi link cssTransitionProp cssProp
	hi link cssPrintProp cssProp
	hi link cssPositioningProp cssProp
	hi link cssBoxProp cssProp
	hi link cssFontDescriptorProp cssProp
	hi link cssFlexibleBoxProp cssProp
	hi link cssBorderOutlineProp cssProp
	hi link cssBackgroundProp cssProp
	hi link cssMarginProp cssProp
	hi link cssListProp cssProp
	hi link cssTableProp cssProp
	hi link cssFontProp cssProp
	hi link cssPaddingProp cssProp
	hi link cssDimensionProp cssProp
	hi link cssRenderProp cssProp
	hi link cssColorProp cssProp
	hi link cssGeneratedContentProp cssProp
endf


"'''''''''''''''''''' function! colorscheme#desert()
function! colorscheme#desert()
	colorscheme desert
	hi Normal guibg=black
	hi NonText guibg=black
	hi MatchParen ctermfg=yellow cterm=bold ctermbg=NONE guifg=yellow gui=bold guibg=NONE
	hi Special cterm=bold
	hi link LineNr Ignore
endf


"'''''''''''''''''''' function! colorscheme#handle_completion(ArgLead, CmdLine, CursorPos)
function! colorscheme#handle_completion(ArgLead, CmdLine, CursorPos)
	return s:schemes
endf

