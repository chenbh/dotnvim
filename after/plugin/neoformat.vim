" pip install black
let g:neoformat_enabled_python = ['black']

" npm install -g prettier
let g:neoformat_enabled_css = ['prettier']

augroup fmt
  autocmd!
  autocmd BufWritePre *.css,*.py undojoin | Neoformat
augroup END
