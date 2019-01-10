if exists('g:quickpick_files')
    finish
endif
let g:quickpick_files = 1

command! Pfiles call quickpick#pickers#files#show()
