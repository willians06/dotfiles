let mapleader = ','

imap kj <ESC>
imap jk <ESC>

set number
set relativenumber
set nowrap
set formatoptions-=t

" On pressing tab, insert 2 spaces
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2

" Copy/paste
set clipboard^=unnamed,unnamedplus

" Terminal
tnoremap <Esc> <C-\><C-n>
set mouse=a
set scrollback=100000 
set sessionoptions+=terminal
autocmd TermOpen * setlocal norelativenumber

" Buffer navigation
nnoremap <leader>l :bn<CR>
nnoremap <leader>h :bp<CR>

if has("win64") || has("win32") || has("win16")
  call plug#begin("c:/Users/Willians/AppData/Local/nvim-data/site/plugged")
else
  call plug#begin("~/.local/share/nvim/plugged/")
endif

Plug 'morhetz/gruvbox' " The best color scheme
Plug 'vim-airline/vim-airline' " Status Bar
Plug 'vim-airline/vim-airline-themes' " Status Bar themes

Plug 'tpope/vim-obsession' " Session Management

Plug 'jiangmiao/auto-pairs'
Plug 'haya14busa/incsearch.vim'
Plug 'phaazon/hop.nvim' " To 'hop' inside the code
Plug 'Yggdroot/indentLine' " for displaying thin vertical lines at each indentation level 

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'stsewd/fzf-checkout.vim'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

Plug 'vim-syntastic/syntastic'

Plug 'leafgarland/typescript-vim' 
Plug 'neoclide/coc-prettier'

Plug 'dart-lang/dart-vim-plugin'
Plug 'udalov/kotlin-vim'

call plug#end()

" airline
set noshowmode 
let g:airline#extensions#tabline#enabled = 1  " Mostrar buffers abiertos (como pestañas)
let g:airline#extensions#tabline#fnamemod = ':t'  " Mostrar sólo el nombre del archivo
let g:airline_powerline_fonts = 1

" Color scheme
set termguicolors  " Activa true colors en la terminal
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_invert_selection='0'
colorscheme gruvbox
set background=dark

" Dart
let g:dart_style_guide = 2
let g:dart_format_on_save = 1
let dart_html_in_string=v:true

" The following two lines are optional. Configure it to your liking!
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" indentLine
let g:indentLine_fileTypeExclude = ['text', 'sh', 'help', 'terminal']
let g:indentLine_bufNameExclude = ['NERD_tree.*', 'term:.*']

" HOP
nnoremap <leader>w :HopWord<CR>

lua << EOF
  require'hop'.setup()
EOF

" Prettier
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" fzf
nnoremap <leader>f :Files<CR>
 
" fzf-checkout
nnoremap <leader>gf :GFiles<CR>
nnoremap <leader>gb :GBranches<CR>

" IncSearch 
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
let g:incsearch#auto_nohlsearch = 1

" GitGutter 
let g:gitgutter_enabled = 1
let g:gitgutter_map_keys = 0 " disable default keybindings
nmap ) <Plug>(GitGutterNextHunk)
nmap ( <Plug>(GitGutterPrevHunk)
nmap <leader>gp <Plug>(GitGutterStageHunk)
set updatetime=250

" Fugitive
nmap <leader>gh :diffget //3<CR>
nmap <leader>gu :diffget //2<CR>
nmap <leader>gs :G<CR>

" COC COC COC COC COC COC COC COC COC COC  

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
nnoremap <leader>prw :CocSearch <C-R>=expand("<cword>")<CR><CR>

