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
set number relativenumber		" add relative line numbers
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END
set wildmode=longest,list   " get bash-like tab completions
set cc=100                  " set an 100 column border for good coding style
set encoding=UTF-8          " utf-8 encoding
filetype plugin indent on   " allows auto-indenting depending on file type
syntax on                   " syntax highlighting

let mapleader=" "

call plug#begin('~/.config/nvim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'christoomey/vim-tmux-navigator'
Plug 'easymotion/vim-easymotion'
Plug 'joshdick/onedark.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'morhetz/gruvbox'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'Lokaltog/powerline'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'
Plug 'zivyangll/git-blame.vim'

call plug#end()

colorscheme gruvbox

map <C-j> <Down>
map <C-k> <Up>
map <C-h> <Left>
map <C-l> <Right>
nnoremap <S-j> 10<C-e>
nnoremap <S-k> 10<C-y>

" Buffers
nnoremap <Leader>n :bp<CR>
nnoremap <Leader>m :bn<CR>
nnoremap <Leader>bd :bn<CR> :bd #<CR>

" Airline
let g:airline_powerline_fonts=1

" Nerd tree
let g:NERDTreeShowHidden=1
let g:NERDTreeMinimalUI=1
let g:NERDTreeQuitOnOpen=1
let g:NERDTreeWinSize=60
" Nerd tree git
let g:NERDTreeGitStatusIndicatorMapCustom = {
                \ 'Modified'  :'✹',
                \ 'Staged'    :'✚',
                \ 'Untracked' :'✭',
                \ 'Renamed'   :'➜',
                \ 'Unmerged'  :'═',
                \ 'Deleted'   :'✖',
                \ 'Dirty'     :'✗',
                \ 'Ignored'   :'☒',
                \ 'Clean'     :'✔︎',
                \ 'Unknown'   :'?',
                \ }
let g:NERDTreeGitStatusUseNerdFonts = 1
map <leader>t :NERDTreeFind<cr>
map <leader>tt :NERDTreeToggle<cr>
map <leader>tc :NERDTreeClose<cr>

" coc neovim
let g:coc_global_extensions = ['coc-css', 'coc-html', 'coc-json', 'coc-tsserver', 'coc-java']

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gds :sp<CR><Plug>(coc-definition)
nmap <silent> gdvs :vsp<CR><Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" YATS
let g:yats_host_keyword = 1

" Easy motion configuration
let g:EasyMotion_startofline = 0 " keep cursor colum when JK motion
let g:EasyMotion_add_search_history = 0

map / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)
map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>h <Plug>(easymotion-linebackward)

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

nnoremap <silent> <C-p> :call fzf#vim#files('.', {'options': '--prompt ""'})<CR>
nnoremap <silent> <leader>b :Buffers<CR>
" π means <A-p> on iTerm2
nnoremap π :Ag<CR> 

" GitGutter
let g:gitgutter_enabled = 0
let g:gitgutter_highlight_linenrs = 1
let g:gitgutter_preview_win_floating = 1
noremap <Leader>ggt :GitGutterToggle<CR>
noremap <Leader>ggh :GitGutterLineNrHighlightsToggle<CR>
noremap <Leader>ggu :GitGutterUndoHunk<CR>
noremap <Leader>ggs :GitGutterPreviewHunk<CR>
noremap <Leader>ggp :GitGutterPrevHunk<CR>
noremap <Leader>ggn :GitGutterNextHunk<CR>

" GitBlame
nnoremap <Leader>s :<C-u>call gitblame#echo()<CR>

