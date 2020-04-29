" Plugins
" - NerdTree
" - Fugitive
" - GitGutter

syntax on
set t_Co=16

" Number and cursorline
set number
set cursorline
highlight LineNr cterm=None ctermfg=grey ctermbg=None 
highlight CursorLine cterm=None ctermfg=None ctermbg=darkgrey
highlight CursorLineNr cterm=bold ctermfg=Yellow ctermbg=None 

" NerdTree toggle
nmap ,k :NERDTreeToggle<CR>

" GitGutter update time
set updatetime=100

" Remap Esc
imap kj <Esc>
imap jk <Esc>

" Scroll 3 lines at a time
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" Splits and navigation
set splitright
set splitbelow
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-H> <C-W><C-H>
nnoremap <C-L> <C-W><C-L>
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>

" Set 80 char limit
set colorcolumn=81
highlight ColorColumn ctermbg=darkgrey

" Tabs and whitespaces
set listchars=space:_,eol:$,tab:>-,trail:~,extends:>,precedes:<
set tabstop=4
set shiftwidth=4
set noexpandtab
set softtabstop=4
autocmd Filetype python setlocal expandtab



