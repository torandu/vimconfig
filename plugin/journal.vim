" Vim plugin for creating and editing journal files

command! -nargs=0 Ej call s:EditJournal() | delcommand Ej

function! s:EditJournal()
    let l:dirname = $HOME . '/notes/journal'
    if !isdirectory(l:dirname)
        call mkdir(l:dirname, 'p')
    endif
    let l:fname = l:dirname . '/' . strftime('%Y-%m-%d_%a')
    edit `=l:fname`
    if empty(filereadable(l:fname))
        put='# JOURNAL=> ' . strftime('%a %d %b %Y')
        put='# TODAY'
        put='# DONE'
        put='# NEXT'
        put='# NOTES'
        exec 'normal! 3G'
    endif
endfunction
