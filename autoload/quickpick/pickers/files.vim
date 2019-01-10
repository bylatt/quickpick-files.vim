if !exists('g:quickpick_files_command')
  let g:quickpick_files_command = 'fd . -t f'
endif

let g:quickpick_files = 1
function! quickpick#pickers#files#show(...) abort
    let id = quickpick#create({
        \   'on_change': function('s:on_change'),
        \   'on_accept': function('s:on_accept'),
        \   'items': s:get_files(0),
        \ })
    call quickpick#show(id)
    return id
endfunction

function! s:get_files(refresh) abort
    if !exists('s:files') || a:refresh
        let s:files = uniq(sort(split(system(g:quickpick_files_command), '\n')))
    endif
    return s:files
endfunction

function! s:on_change(id, action, searchterm) abort
    let searchterm = tolower(a:searchterm)
    let items = empty(trim(searchterm)) ? s:get_files(0) : filter(copy(s:get_files(0)), {index, item-> stridx(tolower(item), searchterm) > -1})
    call quickpick#set_items(a:id, items)
endfunction

function! s:on_accept(id, action, data) abort
    call quickpick#close(a:id)
    execute 'e ' . a:data['items'][0]
endfunction
