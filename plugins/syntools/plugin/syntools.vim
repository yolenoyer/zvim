

noremap <silent> <F1>H :ToggleHL<cr>

command! ShowHL call syntools#enable_auto_show_highlight()
command! HideHL call syntools#disable_auto_show_highlight()
command! ToggleHL call syntools#toggle_auto_show_highlight()

command! HLDisable call syntools#clear_highlight()
command! -nargs=* DispHighlight call syntools#disp_highlight(<q-args>)


