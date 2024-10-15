syntax on                  " Enable syntax highlighting.
filetype plugin indent on  " Enable file type based indentation.

" ----- Default settings ----- {{{
set autoindent             " Respect indentation when starting a new line.
set expandtab              " Expand tabs to spaces. Essential in Python.
set tabstop=4              " Number of spaces tab is counted for.
set shiftwidth=4           " Number of spaces to use for autoindent.
set modifiable
set backspace=2            " Fix backspace behavior on most terminals.
set nowrapscan
set cursorline             " highlight cursor line
set laststatus=2
" set undofile             " Persist undo history between sessions. 
" set folding
set foldmethod=syntax
let javaScript_fold=1
set wildmenu
set wildmode=list:longest,full
set number                 " line numbers
set relativenumber         " relative line numbers
set hlsearch               " highlight coincidences
set linebreak              " soft word wrap
set tags=tags;      " tags

packloadall                " Load all plugins.
silent! helptags ALL       " Load help files for all plugins.
" ----- Default settings ----- }}}

" ----- Remappings ----- {{{
" Fast split navigation with <Ctrl> + hjkl
noremap <c-h> <c-w><c-h>
noremap <c-j> <c-w><c-j>
noremap <c-k> <c-w><c-k>
noremap <c-l> <c-w><c-l>

" Navigating with <Ctrl> + hjkl through terminal mode
tnoremap <c-j> <c-w><c-j>
tnoremap <c-k> <c-w><c-k>
tnoremap <c-l> <c-w><c-l>
tnoremap <c-h> <c-w><c-h>

" remappings for inserting 2 characters instead of 1
"inoremap ' ''<esc>i
"inoremap " ""<esc>i
inoremap ( ()<esc>i
inoremap { {}<esc>i
inoremap [ []<esc>i
inoremap <lt> <lt>><esc>i

cnoremap und UndotreeToggle " remap undotree remap 
" ----- Remappings ----- }}}

" ----- Plugins ----- {{{
" Install vim-plug if it's not already installed.
if empty(glob('~/.vim/autoload/plug.vim'))
silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
\ https://raw.github.com/junegunn/vim-plug/master/plug.vim
autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }  " file navigation
Plug 'tpope/vim-vinegar'                                " to open netrw
" Plug 'ctrlpvim/ctrlp.vim'
" Plug 'mileszs/ack.vim'
Plug 'junegunn/vim-plug'                                " plugin manager
Plug 'Valloric/YouCompleteMe', {'do':'./install.py' }   " auto-completion
Plug 'mbbill/undotree'                                  " undo tree
"Plug 'tpope/vim-fugitive'
Plug 'janko-m/vim-test'
" Plug 'vim-syntastic/syntastic'
Plug 'w0rp/ale'                                         " async (real time) linter 
Plug 'morhetz/gruvbox'                                  " theme
Plug 'sainnhe/everforest'                               " theme
Plug 'itchyny/lightline.vim'                            " status/tabline plugin
Plug 'itchyny/vim-gitbranch'                            " show git branch plugin
"Plug 'vim-airline/vim-airline'                         " status/tabline plugin
call plug#end()
" ----- Plugis ----- }}}

" ----- Plugins configs ----- {{{
" remapping NerdTree
noremap <leader>nt :NERDTreeToggle<enter>

" YouCompleteMe plugin
let g:plug_timeout = 500 " Increase vim-plug timeout for YouCompleteMe
noremap <leader>ycm :YcmCompleter GoTo<enter>

" automatically reload tags after saving a buffer
autocmd BufWritePost *.py silent! !ctags -R &

" Override the :make behavior only when working with Python files
autocmd filetype python setlocal makeprg=pylint\ --reports=n\ --msg-template=\"{path}:{line}:\ {msg_id}\ {symbol},\ {obj}\ {msg}\"\ %:p
autocmd filetype python setlocal errorformat=%f:%l:\ %m

" Syntastic configs
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
"let g:syntastic_python_pylint_exe = 'pylint'


" ----------------------------------- fixing color issues with gruvbox and terminals ---------------------------------------
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX) && getenv('TERM_PROGRAM') != 'Apple_Terminal')
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

" kitty term colors issues 
let &t_ut=''

" show gitbranch in status line
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'gitbranch#name'
      \ },
      \ }

" change folding method for only for .vimrc
augroup vimrc
  au BufReadPre * setlocal foldmethod=marker
  " au BufReadPre * setlocal foldmarker="{{{,}}}"
augroup END
" ----- Plugins configs ----- }}}

" ----- Colorscheme ----- {{{
let g:everforest_background = 'hard'
let g:everforest_better_performance = 1
"let g:airline_theme = 'everforest'
let g:gruvbox_contrast_dark = 'soft'
let g:gruvbox_contrast_light = 'medium'
colorscheme everforest      " Change a colorscheme.
set background=dark         " Setting dark mode
" ----- Colorscheme ----- }}}


" ----- idk other stuff? ----- {{{
" command! Bd :bp | :sp | :bn | :bd  " Close buffer without closing window.

" Set up persistent undo across all files.
"if !isdirectory("$HOME/.vim/undodir")
"    call mkdir("$HOME/.vim/undodir", "p")
"endif
"set undodir="$HOME/.vim/undodir"


" vinegar, not hijack Netrw
" let NERDTreeHijackNetrw = 0
" ----- idk other stuff? ----- }}}
