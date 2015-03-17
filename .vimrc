"=============================================================================
" FileName    :	.vimrc
" Author      :	Sergio Cancelo
" Email       :	yo@sergiocancelo.es
" Description : My VIM Configuration
" Version     :	1.0
" LastChange  :	2014-11-18 17:11:04
" ChangeLog   :
"=============================================================================

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
Plugin 'L9'
" Control P
Plugin 'kien/ctrlp.vim'
" PowerLine
Plugin 'https://github.com/Lokaltog/powerline'
"Airline bar
Plugin 'bling/vim-airline'
" Vim easy motion
Plugin 'Lokaltog/vim-easymotion'
" Author VIM Insertion Plugin
Plugin 'kdurant/AuthorInfo'
" NERD Commenter
Plugin 'scrooloose/nerdcommenter'
" Sintastic
Plugin 'scrooloose/syntastic'
" Vim snippets handler
Plugin 'Serginho/snipMate'
" Vim Surrounding
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-markdown'
" Ruby plugins
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-bundler'
Plugin 'skalnik/vim-vroom' " To run RSpec tests
Plugin 'astashov/vim-ruby-debugger' " Ruby debugger
" Html plugins
Plugin 'mattn/emmet-vim' " Expand html plugin
Plugin 'eshock/vim-matchit' " Vim Machit for expand % function
Plugin 'othree/xml.vim' " Vim XML for handling html tags
"PHP plugins
Plugin 'StanAngeloff/php.vim'
" Javascript plugins
Plugin 'pangloss/vim-javascript' " Javascript identation
" VIM Coffeescript
Plugin 'kchmck/vim-coffee-script'
" VIM Vdebug
Plugin 'joonty/vdebug'
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList          - list configured plugins
" :PluginInstall(!)    - install (update) plugins
" :PluginSearch(!) foo - search (or refresh cache first) for foo
" :PluginClean(!)      - confirm (or auto-approve) removal of unused plugins
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
syntax enable
colorscheme monokai 

set number
set autoindent
" set colorcolumn=+1 " Highlight the first column after textwidth
set cinkeys-=0#  " Treat # as a normal character when indenting
set hlsearch  " When there is a prev search pattern, highlight all its matches
set incsearch  " While typing a search command show first match
set laststatus=2  " Always show status line
set scrolloff=5  " Minimal number of lines to keep above and below the cursor
let mapleader = "," " Leader key

" Airline configuration
set laststatus=2
let g:airline_theme='murmur'
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" Airline unicode symbols
let g:airline_left_sep = '▶'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.whitespace = 'Ξ'

" Author plugin configuration
let g:vimrc_author='Sergio Cancelo'
let g:vimrc_email='yo@sergiocancelo.es'
let g:vimrc_homepage='http://sergiocancelo.es'
nmap <F4> :AuthorInfoDetect<cr> 

" PHP configuration
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType php noremap  :!/usr/bin/php -l %
autocmd FileType php noremap  :w!:!/usr/bin/php %
let g:syntastic_php_checkers = ['php']

" Easy motion configuration
nmap s <Plug>(easymotion-s2)
nmap t <Plug>(easymotion-t2)
map / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)
map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>h <Plug>(easymotion-linebackward)
let g:EasyMotion_startofline = 0 " keep cursor colum when JK motion

" Vim Javascript configuration
let javascript_enable_domhtmlcss = 1
let b:javascript_fold = 1

" Vim Emmet configuration
let g:user_emmet_leader_key='<C-Z>'

" Vdebug for Xdebug
let g:vdebug_options = {}
let g:vdebug_options["port"] = 9009
let g:vdebug_options["host"] = 'localhost'
