" vimrc

let data_dir = '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
    Plug 'ConradIrwin/vim-bracketed-paste'
    Plug 'cespare/vim-toml'
    Plug 'dense-analysis/ale'
    Plug 'git@github.com:torandu/vim-csv-syntax'
    Plug 'godlygeek/tabular'
    Plug 'google/vim-searchindex'
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'
    Plug 'pangloss/vim-javascript'
    Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
    Plug 'prettier/vim-prettier'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-dispatch'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-surround'
call plug#end()

set nocompatible
filetype plugin indent on
syntax on

set hidden
set noswapfile

set bs=start,eol,indent
set ts=4 sts=4 sw=4 et
set cursorline
set scrolloff=3
set bg=dark

let mapleader = ','
set pastetoggle=<Leader>v

set hls
nmap <silent> <BS> :nohlsearch<CR>

set ignorecase
set smartcase

set autoindent
set smartindent

set wildmode=longest,list,full

set laststatus=2
set statusline=%f\ %l/%L,c%c\ %p%%\ %{&paste?'[PASTE]':''}

set nu
nnoremap <silent><Leader>n :set nonu!<CR>

if &diff
    hi DiffChange ctermfg=white ctermbg=blue
    hi DiffText   ctermfg=black ctermbg=yellow
    hi DiffAdd    ctermfg=white ctermbg=green
    hi DiffDelete ctermfg=white ctermbg=red
    syntax off
endif

map <Leader>V :edit $MYVIMRC<CR>

imap jj <ESC>

" current filename
inoremap <Leader>fn <C-R>=expand("%:t")<CR>

iab <expr> dtn strftime("%c")
iab <expr> dtd strftime("%a %d %b %Y")

augroup closeOnQuit
    autocmd!
    autocmd QuitPre * exe "lclose|cclose"
augroup END

augroup editVimrc
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

augroup openFileToLastLocation
    autocmd!
    autocmd BufReadPost *
      \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
      \ |   exe "normal! g`\""
      \ | endif
augroup END

augroup removeTrailingWhitespace
    autocmd!
    autocmd BufWritePre * %s/\s\+$//e
augroup END

" Asynchronous Lint Engine
" https://github.com/dense-analysis/ale
let g:ale_linters_explicit = 1 " only run linters named in ale_linters
" https://github.com/dense-analysis/ale/blob/master/supported-tools.md
let g:ale_linters = {'python': ['ruff'], 'sh': ['shellcheck']}
let g:ale_fixers = {'python': ['ruff', 'black']}
let g:ale_fix_on_save = 1
let g:ale_open_list = 1
let g:ale_set_highlights = 0
let g:ale_lint_delay = 500
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
noremap <F8> :ALEToggleBuffer<CR>
noremap <F9> :ALEFix<CR>

" fzf is a general-purpose command-line fuzzy finder.
" https://github.com/junegunn/fzf.vim
set runtimepath+=/usr/local/opt/fzf
command! Buffers call fzf#run(fzf#wrap({'source': map(range(1, bufnr('$')), 'bufname(v:val)')}))
command! -bang Buffers call fzf#run(fzf#wrap({'source': map(range(1, bufnr('$')), 'bufname(v:val)')}, <bang>0))
command! -bang Buffers call fzf#run(fzf#wrap('buffers', {'source': map(range(1, bufnr('$')), 'bufname(v:val)')}, <bang>0))
nnoremap <silent> <Leader>t :Files<CR>
nnoremap <silent> <Leader>b :Buffers<CR>
nnoremap <silent> <Leader>h :Help<CR>
nnoremap <silent> <Leader>H :helpclose<CR>
