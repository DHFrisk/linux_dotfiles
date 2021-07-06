"set number
filetype plugin indent on
set clipboard=unnamed
set mouse=a
set numberwidth=1
syntax enable
syntax on
set cursorline
set autoindent
set smartindent
set showcmd
set ruler
set encoding=utf-8
set showmatch
set sw=2
set relativenumber
set laststatus=2
set noshowmode
set termguicolors
set laststatus=2
set tabstop=4
set softtabstop=0 noexpandtab
set shiftwidth=4
set softtabstop=0 expandtab shiftwidth=4 smarttab
set autoindent

call plug#begin('~/.vim/plugged')

"General plugins
Plug 'easymotion/vim-easymotion'
Plug 'scrooloose/nerdtree'
Plug 'christoomey/vim-tmux-navigator'
Plug 'vim-scripts/indentpython.vim'
Plug 'vim-syntastic/syntastic'
Plug 'itchyny/lightline.vim'
Plug 'mg979/vim-visual-multi'
Plug 'mattn/emmet-vim'
Plug 'Yggdroot/indentLine'
Plug 'Chiel92/vim-autoformat'
Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'
Plug 'google/vim-glaive'
"Themes plugins
Plug 'sonph/onehalf', { 'rtp':'vim'}
Plug 'morhetz/gruvbox'

"Plugins for PHP
Plug 'StanAngeloff/php.vim'
call plug#end()

"gruvbox
let g:gruvbox_contrast_dark = 'hard'
"colorscheme gruvbox

"onehalf
colorscheme onehalfdark
let g:airline_theme='onehalfdark'

let mapleader= " "
nmap <Leader>s <Plug>(easymotion-s2)
nmap <Leader>nt :NERDTreeFind<CR>
let NERDTreeQuitOnOpen=1
let python_highlight_all=1
syntax on

"indentLine Plugin
let g:indentLine_char_list = ['|', '¦', '┆', '┊']

"Google code format Plugin
augroup autoformat_settings
  autocmd FileType bzl AutoFormatBuffer buildifier
  autocmd FileType c,cpp,proto,javascript,arduino AutoFormatBuffer clang-format
  autocmd FileType dart AutoFormatBuffer dartfmt
  autocmd FileType go AutoFormatBuffer gofmt
  autocmd FileType gn AutoFormatBuffer gn
  autocmd FileType html,css,sass,scss,less,json AutoFormatBuffer js-beautify
  autocmd FileType java AutoFormatBuffer google-java-format
  autocmd FileType python AutoFormatBuffer yapf
  " Alternative: autocmd FileType python AutoFormatBuffer autopep8
  autocmd FileType rust AutoFormatBuffer rustfmt
  autocmd FileType vue AutoFormatBuffer prettier
augroup END
