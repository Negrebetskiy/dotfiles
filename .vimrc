" General
syntax on
set ruler
set number
set mouse=a
set nowrap
set t_Co=16 " better system colors


" Indentation
set tabstop=2
set shiftwidth=2
set smarttab
set expandtab
set smartindent


" Highlighting
set showmatch
set hlsearch
set incsearch
set ignorecase

" Special wrapping for tex files
autocmd FileType tex setlocal wrap linebreak


" Mappings
nnoremap <C-A> <C-W>< " resize splits
nnoremap <C-D> <C-W>>
nnoremap <C-W> <C-W>+
nnoremap <C-S> <C-W>-

set cursorline
hi CursorLine cterm=none
hi CursorLineNR cterm=bold ctermfg=yellow

runtime tabline.vim
