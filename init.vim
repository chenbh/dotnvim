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
" but don't break the built in open file functionality
nnoremap o <cr>

" highligh trailing spaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

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

" enable mouse clicking and scrolling
set mouse=a

" open quickfix files in last used window
set switchbuf=uselast

" folds
set foldmethod=syntax
set foldlevel=999
" close all toplevel folds
nmap zT :%foldc<cr>


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
Plug 'morhetz/gruvbox'
Plug 'airblade/vim-gitgutter'
call plug#end()


" color schemes
set termguicolors
syntax enable
let g:gruvbox_contrast_dark = "dark"
colorscheme gruvbox


" FZF
nnoremap <C-space> :FZF<cr>


" terminal
command -nargs=? OpenTerm vnew | term <args>
nnoremap t :OpenTerm<cr>
cnoreabbrev ! OpenTerm


" language-specific configuration
runtime! lang/*.vim


" YCM
" sensible shortcuts
nnoremap gd :YcmCompleter GoTo<CR>
nnoremap gD :YcmCompleter GoToDefinition<CR>
nnoremap gi :YcmCompleter GoToImplementation<CR>
nnoremap gt :YcmCompleter GetType<CR>
nnoremap gr :YcmCompleter GoToReferences<CR>
nnoremap gf :YcmCompleter FixIt<CR>

nnoremap yi :YcmShowDetailedDiagnostic<CR>
nnoremap yr :YcmRestartServer<CR>


" populate location list
let g:ycm_always_populate_location_list = 1

" load lsp
runtime ycm_lsp.vim
