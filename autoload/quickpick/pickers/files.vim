function! quickpick#pickers#files#show(...) abort
    let id = quickpick#create({
        \   'on_change': function('s:on_change'),
        \   'on_accept': function('s:on_accept'),
        \   'items': s:get_files(0),
        \ })
    call quickpick#show(id)
    return id
endfunction

function! s:add_files(dir) abort
    let l:fs = []
    for f in map(readdir(a:dir), 'a:dir . "/".  v:val')
        if isdirectory(f)
            let fs = fs + s:add_files(f)
        else
            call add(l:fs, f)
        endif
    endfor
    return fs
endfunction

function! s:get_files(refresh) abort
    if !exists('s:files') || a:refresh
        if exists('g:quickpick_files_command')
            let s:files = uniq(sort(split(system(g:quickpick_files_command), '\n')))
        else
            let s:files = uniq(sort(s:add_files(getcwd())))
        endif
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
