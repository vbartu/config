
"tags, registers, marks, record
set encoding=utf-8
set mouse=a

" Colors
syntax on
"set termguicolors
colorscheme torte

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
		highlight StatusModeColor ctermbg=100
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
imap kj <Esc>
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

" Set 80 char limit
nmap <silent> <F2> :execute "set colorcolumn=" . (&colorcolumn == "" ? "80" : "")<CR>
highlight ColorColumn ctermfg=red ctermbg=238 cterm=None

" Show whitespaces
highlight NonText ctermfg=239 ctermbg=None cterm=None
highlight SpecialKey ctermfg=239 ctermbg=None cterm=None
set listchars=space:·,eol:¬,tab:▸\ ,trail:~,precedes:«,extends:»
set list
nmap <silent> <F3> :set list!<CR>
set list

"Tab config
set tabstop=4
set shiftwidth=4
set noexpandtab
set softtabstop=4
autocmd Filetype python setlocal expandtab
