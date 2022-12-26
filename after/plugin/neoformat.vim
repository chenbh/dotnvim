" pip install yapf
let g:neoformat_python_yapf = { 'exe': 'yapf', 'args': ['--style google'], 'stdin': 1 }
let g:neoformat_enabled_python = ['yapf']

" npm install -g prettier
let g:neoformat_enabled_css = ['prettier']

augroup fmt
  autocmd!
  autocmd BufWritePre *.css,*.py undojoin | Neoformat
augroup END
