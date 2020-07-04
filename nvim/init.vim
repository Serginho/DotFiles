set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching brackets.
set ignorecase              " case insensitive matching
set hlsearch                " highlight search results
set incsearch               " While typing a search command show first match
set tabstop=2               " number of columns occupied by a tab character
set softtabstop=2           " see multiple spaces as tabstops so <BS> does the right thing
set scrolloff=3             " Minimal number of lines to keep above and below the cursor
set expandtab               " converts tabs to white space
set shiftwidth=2            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed
set relativenumber					" add relative line numbers
set wildmode=longest,list   " get bash-like tab completions
set cc=100                  " set an 100 column border for good coding style
set encoding=UTF-8          " utf-8 encoding
filetype plugin indent on   " allows auto-indenting depending on file type
syntax on                   " syntax highlighting

let mapleader=","

call plug#begin('~/.config/nvim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'christoomey/vim-tmux-navigator'
Plug 'easymotion/vim-easymotion'
Plug 'joshdick/onedark.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ryanoasis/vim-devicons'
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'


call plug#end()

colorscheme onedark

" Nerd tree
let g:NERDTreeShowHidden=1
let g:NERDTreeMinimalUI=1
let g:NERDTreeQuitOnOpen=1

" coc neovim
let g:coc_global_extensions = ['coc-css', 'coc-html', 'coc-json', 'coc-tsserver', 'coc-java']

" YATS
let g:yats_host_keyword = 1

" Easy motion configuration
let g:EasyMotion_startofline = 0 " keep cursor colum when JK motion
let g:EasyMotion_add_search_history = 0

" Vim Emmet configuration
let g:user_emmet_leader_key='<leader>e'

" FZF
let g:fzf_action = {'ctrl-t': 'tab split', 'ctrl-s': 'split', 'ctrl-v': 'vsplit'}
let g:fzf_layout = { 'window': 'call FloatingFZF()' }

function! FloatingFZF()
  let buf = nvim_create_buf(v:false, v:true)
  call setbufvar(buf, '&signcolumn', 'no')

  let height = float2nr(10)
  let width = float2nr(160)
  let horizontal = float2nr((&columns - width) / 2)
  let vertical = 1

  let opts = {
        \ 'relative': 'editor',
        \ 'row': vertical,
        \ 'col': horizontal,
        \ 'width': width,
        \ 'height': height,
        \ 'style': 'minimal'
        \ }

  call nvim_open_win(buf, v:true, opts)
endfunction

" Mapping 
map <C-j> <Down>
map <C-k> <Up>
map <C-h> <Left>
map <C-l> <Right>
nnoremap <S-j> 10<C-e>
nnoremap <S-k> 10<C-y>

map <leader>t :NERDTreeFind<cr>
map <leader>tt :NERDTreeToggle<cr>

" FZF
nnoremap <silent> <C-p> :call fzf#vim#files('.', {'options': '--prompt ""'})<CR>
nnoremap <silent> <leader>b :Buffers<CR>

" Easy motion
map / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)
map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>h <Plug>(easymotion-linebackward)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gds :sp<CR><Plug>(coc-definition)
nmap <silent> gdvs :vsp<CR><Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" GitGutter
noremap ggt :GitGutterToggle<CR>
noremap ggh :GitGutterLineNrHighlightsToggle<CR>
noremap ggu :GitGutterUndoHunk<CR>
noremap ggs :GitGutterPreviewHunk<CR>
noremap ggp :GitGutterPrevHunk<CR>
noremap ggn :GitGutterNextHunk<CR>

