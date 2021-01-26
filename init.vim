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


function! BuildYCM(info)
  if a:info.status == 'installed' || a:info.force
    !../../setup_ycm_build.sh
    !./install.py
  endif
endfunction


" Plugins
call plug#begin('~/.config/nvim/plugged')
Plug 'mileszs/ack.vim'
Plug 'valloric/YouCompleteMe', { 'do': function('BuildYCM') }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'vito/booklit.vim'
Plug 'morhetz/gruvbox'
call plug#end()

" color schemes
set termguicolors
syntax enable
let g:gruvbox_contrast_dark = "dark"
colorscheme gruvbox

" fzf
nnoremap <C-space> :FZF<cr>


" YCM
" sensible shortcuts
nnoremap gd :YcmCompleter GoTo<CR>
nnoremap gD :YcmCompleter GoToDefinition<CR>
nnoremap gi :YcmCompleter GoToImplementation<CR>
nnoremap gt :YcmCompleter GetType<CR>
nnoremap gr :YcmCompleter GoToReferences<CR>
nnoremap gf :YcmCompleter FixIt<CR>

" GoToImplementation populates the QuickFix list. By default <cr> is used to
" open a file on the qf list, but we remapped it to save file on line 16.
function! s:CustomYcmQuickFixWindow()
  nnoremap o <cr>
endfunction
autocmd User YcmQuickFixOpened call s:CustomYcmQuickFixWindow()

" populate location list
let g:ycm_always_populate_location_list = 1

" load lsp
runtime ycm_lsp.vim
