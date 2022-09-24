" Plugins
call plug#begin('~/.config/nvim/plugged')
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

Plug 'SirVer/ultisnips'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'

Plug 'mileszs/ack.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'

Plug 'morhetz/gruvbox'
Plug 'airblade/vim-gitgutter'
call plug#end()


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

" except for in quickfix and location lists
augroup quickfix
  autocmd FileType qf nnoremap <buffer> <cr> <cr>
  autocmd FileType qf nmap <buffer> o <cr>
augroup end

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

" use rg instead of ack
if executable('rg')
  let g:ackprg = 'rg --vimgrep --smart-case'
  cnoreabbrev Rg Ack
endif

" scrolling (without moving cursor)
nnoremap <C-e> 5<C-e>
nnoremap <C-y> 5<C-y>

" disable scratch preview window
set completeopt=menu,menuone,noselect

" enable mouse clicking and scrolling
set mouse=a

" open quickfix files in last used window
set switchbuf=uselast

" folds
set foldmethod=syntax
set foldlevel=999
" close all toplevel folds
nmap zT :%foldc<cr>

" color schemes
set termguicolors
syntax enable
let g:gruvbox_contrast_dark = "dark"
colorscheme gruvbox

" terminal
command -nargs=? OpenTerm vnew | term <args>
nnoremap t :OpenTerm<cr>
cnoreabbrev ! OpenTerm

" language-specific configuration
runtime! lang/*.vim

" increase maxmempattern to search in large files
set mmp=2000000

" always use system clipboard for yanks
set clipboard+=unnamedplus

lua require('lsp')
