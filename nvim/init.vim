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
set wildmode=longest,list   " get bash-like tab completions
set cc=80                   " set an 80 column border for good coding style
set encoding=UTF-8          " utf-8 encoding
filetype plugin indent on   " allows auto-indenting depending on file type
syntax on                   " syntax highlighting

:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END

" Fix nvim 0.7 <C-M> nativa maping
autocmd UIEnter * if v:event.chan ==# 0 | call chansend(v:stderr, "\x1b[>1u") | endif
autocmd UILeave * if v:event.chan ==# 0 | call chansend(v:stderr, "\x1b[<1u") | endif

let mapleader=" "


call plug#begin('~/.config/nvim/plugged')

Plug 'akinsho/bufferline.nvim'
Plug 'alvan/vim-closetag'
Plug 'airblade/vim-gitgutter'
Plug 'breuckelen/vim-resize'
Plug 'gfanto/fzf-lsp.nvim'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'L3MON4D3/LuaSnip'
Plug 'morhetz/gruvbox'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'nvim-lualine/lualine.nvim'
Plug 'preservim/nerdcommenter'
Plug 'ryanoasis/vim-devicons'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'scrooloose/nerdtree'
Plug 'zivyangll/git-blame.vim'
Plug 'nvim-lua/plenary.nvim'

call plug#end()

colorscheme gruvbox

" Search
nnoremap <silent> <Esc><Esc> :let @/ = ""<CR>

" Shortcuts to quickly windows management.
map <leader>s :split<CR><c-w>j
map <leader>vs :vsplit<CR><c-w>l

map <leader>h :1wincmd h<CR>
map <leader>j :2wincmd j<CR>
map <leader>k :3wincmd k<CR>
map <leader>l :4wincmd l<CR>

nnoremap <S-j> 10<C-e>
nnoremap <S-k> 10<C-y>

nnoremap <silent> <c-h> :CmdResizeLeft<cr>
nnoremap <silent> <c-j> :CmdResizeDown<cr>
nnoremap <silent> <c-k> :CmdResizeUp<cr>
nnoremap <silent> <c-l> :CmdResizeRight<cr>

" Buffers
nnoremap <C-n> :bp<CR>
nnoremap <C-m> :bn<CR>
nnoremap <leader>d :bp\|bd #<cr>
nnoremap <leader>D :%bd\|e#<cr>
nnoremap <leader>abd :%bd<cr> 

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
map <leader>tf :NERDTreeFind<cr>
map <leader>tt :NERDTreeToggle<cr>
map <leader>tc :NERDTreeClose<cr>
map <leader>tr :NERDTreeRefreshRoot<cr>

" Nerd commenter
map <leader>ñ <plug>NERDCommenterToggle

" FZF
let g:fzf_action = {'ctrl-t': 'tab split', 'ctrl-s': 'split', 'ctrl-v': 'vsplit'}
let g:fzf_layout = { 'window': 'call FloatingFZF()' }

function! FloatingFZF()
  let buf = nvim_create_buf(v:false, v:true)
  call setbufvar(buf, '&signcolumn', 'no')

  let height = float2nr(40)
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

" Lua line
lua << END
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}
END

" Language service

set completeopt=menu,menuone,noselect

lua << EOF

local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
    --vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
    require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
    -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
    -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  mapping = {
    ['<CR>'] = cmp.mapping.confirm({select = true}),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-i>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-o>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ["<Tab>"] = cmp.mapping(function(fallback)
      if luasnip.expandable() then
        luasnip.expand()
      elseif cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.jumpable(1) then
        luasnip.jump(1)
      else
        fallback() 
      end
    end, {"i", "s"}),

    ["<S-Tab>"] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {"i", "s"})
  },
  sources = cmp.config.sources({
  { name = 'nvim_lsp' },
  -- { name = 'vsnip' }, -- For vsnip users.
  { name = 'luasnip' }, -- For luasnip users.
  -- { name = 'ultisnips' }, -- For ultisnips users.
  -- { name = 'snippy' }, -- For snippy users.
  }, {
  { name = 'buffer' },
  })
})
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
  { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it. 
  }, {
  { name = 'buffer' },
  })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
    }
  })

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
  { name = 'path' }
  }, {
  { name = 'cmdline' }
  })
})

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<leader>gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>gh', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<leader>nd', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', '<leader>pd', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  buf_set_keymap('n', '<leader>o', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'tsserver' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    capabilities = capabilities,
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

-- Fzf lsp
require'fzf_lsp'.setup()


EOF


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

" Bufferline

lua << EOF
vim.opt.termguicolors = true
require("bufferline").setup{
options = {
  show_buffer_close_icons = false,
  show_buffer_icons = true,
  separator_style = "thin"
  }
}
EOF

" Luasnip

lua << EOF
require("luasnip.loaders.from_vscode").lazy_load({ paths = { "~/.config/nvim/snippets" } })
EOF
