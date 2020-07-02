execute pathogen#infect()

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

" YCM
" sensible shortcuts
nnoremap gd :YcmCompleter GoTo<CR>
nnoremap gD :YcmCompleter GoToDefinition<CR>
nnoremap gI :YcmCompleter GoToImplementation<CR>
nnoremap gt :YcmCompleter GetType<CR>

" populate location list
let g:ycm_always_populate_location_list = 1
