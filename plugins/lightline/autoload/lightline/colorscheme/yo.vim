
" Colorscheme personnalisé pour le plugin lightline

let s:base03 = [ '#151513', 233 ]
let s:base02 = [ '#30302c ', 236 ]
let s:base01 = [ '#4e4e43', 239 ]
let s:base00 = [ '#666656', 242  ]
let s:base0 = [ '#808070', 244 ]
let s:base1 = [ '#949484', 246 ]
let s:base2 = [ '#a8a897', 248 ]
let s:base3 = [ '#e8e8d3', 253 ]
let s:yellow = [ '#d8af5f', 3 ]
let s:orange = [ '#d7875f', 216 ]
let s:red = [ '#d68787', 131 ]
let s:magenta = [ '#df5f87', 168 ]
let s:peach = [ '#d7afaf', 181 ]
let s:blue = [ '#87afaf', 109 ]
let s:cyan = [ '#87d7d7', 23 ]
let s:lcyan = [ '#304747', 123 ]
let s:green = [ '#87af87', 108 ]
let s:white = [ '#d0d0d0', 252 ]


let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}
let s:p.normal.left = [ [ s:blue, s:base02 ], [ s:base3, s:base01 ], [ s:base3, s:base02 ], [ s:base3, s:base02 ] ]
let s:p.normal.right = [ [ s:base02, s:base1 ], [ s:base3, s:base01 ] ]
let s:p.inactive.right = [ [ s:base02, s:base00 ], [ s:base0, s:base02 ] ]
let s:p.inactive.left =  [ [ s:base0, s:base02 ], [ s:base00, s:base02 ] ]
let s:p.insert.left = [ [ s:blue, s:base02 ], [ s:base3, s:base01 ] ]
let s:p.replace.left = [ [ s:blue, s:base02 ], [ s:base3, s:base01 ] ]
let s:p.visual.left = [ [ s:blue, s:base02 ], [ s:base3, s:base01 ] ]
let s:p.normal.middle = [ [ s:base3, s:base02 ] ]
let s:p.inactive.middle = [ [ s:base00, s:base02 ] ]
let s:p.tabline.left = [ [ s:base3, s:base02 ] ]
let s:p.tabline.tabsel = [ [ s:base3, s:base00 ] ]
let s:p.tabline.middle = [ [ s:base01, s:base03 ] ]
let s:p.tabline.right = [ [ s:base2, s:base02 ] ]
let s:p.normal.error = [ [ s:red, s:base02 ] ]
let s:p.normal.warning = [ [ s:yellow, s:base01 ] ]
let s:p.normal.git = [ [ s:orange, s:base02 ] ]


command! LightlineColorscheme call s:install()


let s:first = 1

function! s:install()
	hi Lightline_Pysv cterm=bold gui=bold ctermfg=214 ctermbg=236 guifg=#e8e8d3 guibg=#30302c
	if s:first
		let s:first = 0
		let g:lightline#colorscheme#yo#palette = lightline#colorscheme#flatten(s:p)
	endif
endf

