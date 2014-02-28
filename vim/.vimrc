syntax on 
set tabstop=4
set ai
set expandtab
set shiftwidth=4
set softtabstop=4
set showmatch
set background=dark
set hlsearch
set number
set fileformats=unix            " only do unix for EOL terminators
set fileformat=unix             " use UNIX line terminators
set incsearch

" Zen Coding
  let g:user_zen_settings = {
  \  'php' : {
  \    'extends' : 'html',
  \    'filters' : 'c',
  \  },
  \  'xml' : {
  \    'extends' : 'html',
  \  },
  \  'haml' : {
  \    'extends' : 'html',
  \  },
  \  'indentation' : '  ',
  \  'perl' : {
  \    'aliases' : {
  \      'req' : 'require '
  \    },
  \    'snippets' : {
  \      'use' : "use strict\nuse warnings\n\n",
  \      'warn' : "warn \"|\";",
  \    }
  \  }
  \}

  let g:user_zen_expandabbr_key = '<c-e>'

  let g:use_zen_complete_tag = 1
