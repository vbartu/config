
" TODO: tags, registers, marks, record
" :h index :map
set encoding=utf-8
set mouse=a
command Reload source ~/.vimrc

" Theme and colors
syntax on
set hlsearch
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
colorscheme onehalfdark
highlight Normal guibg=#000000 "guifg=#FFFFFF
highlight LineNr guibg=#000000

" Folding
nmap <silent> <F4> :execute "set foldcolumn=" . (&foldcolumn == "0" ? "4" : "0")<CR>
set nofoldenable
set foldmethod=indent

" Fast scrolling
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" Buffers
set hidden
nmap gb :ls<CR>:b<Space>

" Status line
highlight StatusModeColor ctermfg=15 ctermbg=231 cterm=Bold
autocmd WinLeave * highlight StatusModeColor ctermfg=15 ctermbg=239 cterm=Bold

function! StatusMode()
	let mode = mode()
	if mode == "n"
		highlight StatusModeColor ctermbg=28
		return " NORMAL "
	elseif mode == "i"
		highlight StatusModeColor ctermbg=148
		return " INSERT "
	elseif mode == "v"
		highlight StatusModeColor ctermbg=99
		return " VISUAL "
	else
		return ""
	endif
endfunction
highlight StatusLine ctermfg=39 ctermbg=236 cterm=Bold
highlight StatusLineNC ctermfg=241 ctermbg=236 cterm=Bold
set laststatus=2
set statusline=
set statusline+=\ %#StatusModeColor#
set statusline+=%{StatusMode()}
set statusline+=%##
set statusline+=\ %f%m%=
set statusline+=%{v:register}
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\ %3p%%\ %4l:%-3c

" Number and cursorline
set number
set cursorline
highlight LineNr ctermfg=grey ctermbg=None cterm=None
highlight CursorLine ctermfg=None ctermbg=236 cterm=None
highlight CursorLineNr ctermfg=Yellow ctermbg=None cterm=None

" Remap Esc
imap jk <Esc>

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
nmap <silent> <F2> :execute "set colorcolumn=" . (&colorcolumn == "" ? "80" : "")<CR>
highlight ColorColumn ctermfg=red ctermbg=238 cterm=None

" Show whitespaces
highlight NonText ctermfg=239 ctermbg=NONE cterm=NONE guifg=#2b2b2b guibg=NONE guisp=NONE
highlight SpecialKey ctermfg=239 ctermbg=NONE cterm=NONE guifg=#2b2b2b guibg=NONE gui=NONE
set listchars=space:·,eol:¬,tab:▸\ ,trail:~,precedes:«,extends:»
nmap <silent> <F3> :set list!<CR>

" Tab config
set tabstop=4
set shiftwidth=4
set noexpandtab
set softtabstop=4
autocmd Filetype python setlocal expandtab
set autoindent
inoremap <S-Tab> <C-d>

" Python docstring plugin
command! -nargs=0 -range=0 -complete=customlist,pydocstring#insert Pydocstring call pydocstring#insert(<q-args>, <count>, <line1>, <line2>)
command! -nargs=0 -complete=customlist,pydocstring#format PydocstringFormat call pydocstring#format()

" FZF plugin
nmap gy :FZF<CR>

" Signify plugin
set updatetime=100
