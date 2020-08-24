" use bash to execute stuff
set shell=/bin/bash

" tab stuff
set shiftwidth=2
set tabstop=2
set autoindent
set expandtab

" show line numbers
set number

" save on enter
nmap <cr> :w<cr>

" clear highlights on space
nmap <space> :noh<cr>

" shorthand for window switching
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

" use ag instead of ack
if executable('ag')
  let g:ackprg = 'ag --vimgrep --smart-case'
  cnoreabbrev Ag Ack
endif

" disable scratch preview window
set completeopt-=preview

" Plugins
call plug#begin('~/.config/nvim/plugged')
Plug 'mileszs/ack.vim'
Plug 'valloric/YouCompleteMe'
Plug 'fatih/vim-go'
Plug 'elmcast/elm-vim'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-enuch'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
call plug#end()

" vim-go
let g:go_code_completion_enabled = 0
let g:go_fmt_fail_silently = 1
let g:go_imports_autosave = 1
let g:go_fmt_command = "goimports"
let g:go_def_mapping_enabled = 0
let g:go_gopls_enabled = 0


" YCM
" sensible shortcuts
nnoremap gd :YcmCompleter GoTo<CR>
nnoremap gD :YcmCompleter GoToDefinition<CR>
nnoremap gI :YcmCompleter GoToImplementation<CR>
nnoremap gt :YcmCompleter GetType<CR>

" GoToImplementation populates the QuickFix list. By default <cr> is used to
" open a file on the qf list, but we remapped it to save file on line 16.
function! s:CustomYcmQuickFixWindow()
  nnoremap o <cr>
endfunction
autocmd User YcmQuickFixOpened call s:CustomYcmQuickFixWindow()

" populate location list
let g:ycm_always_populate_location_list = 1
