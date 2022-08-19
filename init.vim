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

" alternative way of esc
inoremap jk <esc>
inoremap kj <esc>

" scrolling (without moving cursor)
nnoremap <C-e> 5<C-e>
nnoremap <C-y> 5<C-y>


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
    !./install.py --go-completer
  endif
endfunction


" Plugins
call plug#begin('~/.config/nvim/plugged')
Plug 'mileszs/ack.vim'
Plug 'valloric/YouCompleteMe', { 'do': function('BuildYCM') }
Plug 'fatih/vim-go'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'morhetz/gruvbox'
Plug 'airblade/vim-gitgutter'
call plug#end()

" vim-go
let g:go_code_completion_enabled = 0
let g:go_fmt_fail_silently = 1
let g:go_imports_autosave = 1
let g:go_fmt_command = "goimports"
let g:go_def_mapping_enabled = 0
let g:go_gopls_enabled = 0
let g:go_template_autocreate = 0


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


" increase maxmempattern to search in large files
set mmp=2000000


" YCM
" sensible shortcuts
nnoremap gd :YcmCompleter GoTo<CR>
nnoremap gD :YcmCompleter GoToDefinition<CR>
nnoremap gi :YcmCompleter GoToImplementation<CR>
nnoremap gy :YcmCompleter GetType<CR>
nnoremap gr :YcmCompleter GoToReferences<CR>
nnoremap gf :YcmCompleter FixIt<CR>
nnoremap gR :YcmCompleter RefactorRename

nnoremap yi :YcmShowDetailedDiagnostic<CR>
nnoremap yr :YcmRestartServer<CR>


" populate location list
let g:ycm_always_populate_location_list = 1

" load lsp
runtime ycm_lsp.vim
