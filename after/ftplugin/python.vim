setlocal ts=4 sts=4 sw=4 et nu
setlocal textwidth=88
setlocal colorcolumn=+1

nnoremap <buffer> <F11> :exec '! clear; python -m pdb' shellescape(@%, 1)<cr>
nnoremap <buffer> <F12> :exec '! clear; python' shellescape(@%, 1)<cr>

iabbrev hp #!/usr/bin/env python3<CR>
iabbrev ifm if __name__ == '__main__':<CR>

let b:dispatch = 'pytest'
map <Leader>d :Dispatch<CR>
