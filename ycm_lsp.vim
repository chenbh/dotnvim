let g:ycm_language_server =
  \ [
  \   {
  \     'name': 'bash',
  \     'cmdline': [ 'bash-language-server', '--stdio' ],
  \     'filetypes': [ 'sh' ]
  \   },
  \   {
  \     'name': 'elm',
  \     'cmdline': [ 'elm-language-server', '--stdio' ],
  \     'filetypes': [ 'elm' ],
  \     'project_root_files': [ 'elm.json' ]
  \   },
  \ ]
