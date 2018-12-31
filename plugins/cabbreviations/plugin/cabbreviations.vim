
" Ajoute les alias de commandes usuelles.


let g:aliases = {
\	'te'  : 'tabe',
\	'tn'  : 'tabnew',
\	'ts'  : 'tab split',
\	'tb'  : 'tab split\|b',
\
\	've'  : 'vsplit',
\	'vn'  : 'vnew',
\	'vb'  : 'vsplit\|b',
\
\	'wso' : 'w\|so %',
\	'ws'  : 'w\|so %',
\
\	'mc'  : 'mapclear',
\	'mcb' : 'mapclear <buffer>',
\	'cmb' : 'mapclear <buffer>',
\	'fs'  : 'FontSize',
\
\	'wd'  : 'windo',
\	'td'  : 'tabdo',
\
\
\
\	'th'  : 'tab h',
\	'vh'  : 'vert h',
\	'yh'  : 'vert h',
\
\	'hf'  : 'h function-list',
\	'thf' : 'tab h function-list',
\	'vhf' : 'vert h function-list',
\	'yhf' : 'vert h function-list',
\
\	'hfs'  : 'h string-functions',
\	'thfs' : 'tab h string-functions',
\	'vhfs' : 'vert h string-functions',
\	'yhfs' : 'vert h string-functions',
\
\	'hfl'  : 'h list-functions',
\	'thfl' : 'tab h list-functions',
\	'vhfl' : 'vert h list-functions',
\	'yhfl' : 'vert h list-functions',
\
\	'hfd'  : 'h dict-functions',
\	'thfd' : 'tab h dict-functions',
\	'vhfd' : 'vert h dict-functions',
\	'yhfd' : 'vert h dict-functions',
\
\	'hff'  : 'h float-functions',
\	'thff' : 'tab h float-functions',
\	'vhff' : 'vert h float-functions',
\	'yhff' : 'vert h float-functions',
\
\	'hfv'  : 'h var-functions',
\	'thfv' : 'tab h var-functions',
\	'vhfv' : 'vert h var-functions',
\	'yhfv' : 'vert h var-functions',
\
\	'hfc'  : 'h cursor-functions',
\	'thfc' : 'tab h cursor-functions',
\	'vhfc' : 'vert h cursor-functions',
\	'yhfc' : 'vert h cursor-functions',
\
\	'hfm'  : 'h mark-functions',
\	'thfm' : 'tab h mark-functions',
\	'vhfm' : 'vert h mark-functions',
\	'yhfm' : 'vert h mark-functions',
\
\	'hft'  : 'h text-functions',
\	'thft' : 'tab h text-functions',
\	'vhft' : 'vert h text-functions',
\	'yhft' : 'vert h text-functions',
\
\	'hfsy'  : 'h system-functions',
\	'thfsy' : 'tab h system-functions',
\	'vhfsy' : 'vert h system-functions',
\	'yhfsy' : 'vert h system-functions',
\
\	'hfb'  : 'h buffer-functions',
\	'thfb' : 'tab h buffer-functions',
\	'vhfb' : 'vert h buffer-functions',
\	'yhfb' : 'vert h buffer-functions',
\
\	'hfw'  : 'h window-functions',
\	'thfw' : 'tab h window-functions',
\	'vhfw' : 'vert h window-functions',
\	'yhfw' : 'vert h window-functions',
\
\	'hfsyn'  : 'h syntax-functions',
\	'thfsyn' : 'tab h syntax-functions',
\	'vhfsyn' : 'vert h syntax-functions',
\	'yhfsyn' : 'vert h syntax-functions',
\
\	'hfhi'  : 'h syntax-functions',
\	'thfhi' : 'tab h syntax-functions',
\	'vhfhi' : 'vert h syntax-functions',
\	'yhfhi' : 'vert h syntax-functions',
\
\	'hp'  : 'h pattern-overview',
\	'thp' : 'tab h pattern-overview',
\	'vhp' : 'vert h pattern-overview',
\	'yhp' : 'vert h pattern-overview',
\
\	'he'  : 'h autocommand-events',
\	'the' : 'tab h autocommand-events',
\	'vhe' : 'vert h autocommand-events',
\	'yhe' : 'vert h autocommand-events',
\
\	'hc'  : 'h :command-nargs',
\	'thc' : 'tab h :command-nargs',
\	'vhc' : 'vert h :command-nargs',
\	'yhc' : 'vert h :command-nargs',
\
\	'ha'  : 'h local-additions',
\	'tha' : 'tab h local-additions',
\	'vha' : 'vert h local-additions',
\	'yha' : 'vert h local-additions',
\}

call _#cabbr(g:aliases)

