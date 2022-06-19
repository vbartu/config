set encoding=utf-8
set mouse=a
set hidden " Allow hidden buffers
let mapleader="," " Leader key
inoremap jk <Esc>


" Clipboard copy/paste
nnoremap <leader>d "+d
nnoremap <leader>y "+y
nnoremap <leader>p "+p
vnoremap <leader>d "+d
vnoremap <leader>y "+y
vnoremap <leader>p "+p

"
" Quick edit vimrc
:nnoremap <leader>ev :tabe $MYVIMRC<cr>
:nnoremap <leader>r :source $MYVIMRC<cr>


" Theme and colors
syntax on
set hlsearch
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
colorscheme onehalfdark


" Number and cursorline
set number
set cursorline


" Tab default config
set noexpandtab    " if set, spaces instead of tabs
set tabstop=4      " tab char looks like 4 spaces
set shiftwidth=4   " tab length for <</>>, depends on expandtab
set smarttab       " shiftwidth used also in front of line, ts/sts otherwise
set softtabstop=4  " soft tab length (uses mix of tabs and spaces)
set shiftround     " shift indent to shiftwdth multiple
set autoindent     " copies current indent to new line
inoremap <S-Tab> <C-d>


" Navigation
set splitright
set splitbelow
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-H> <C-W><C-H>
nnoremap <C-L> <C-W><C-L>
nnoremap H 0
nnoremap L $
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>


" Status line
"autocmd WinLeave * highlight StatusModeColor ctermfg=15 ctermbg=239 cterm=Bold
function! StatusMode()
	let mode = mode()
	if mode == "n"
		return " NORMAL "
	elseif mode == "i"
		return " INSERT "
	elseif mode == "v"
		return " VISUAL "
	else
		return ""
	endif
endfunction
set laststatus=2
set statusline=
set statusline+=\ %{StatusMode()}
set statusline+=\ %f%m%=
set statusline+=%{v:register}
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\ %3p%%\ (%l/%L)\ %4l:%-3c


" Functions
"
" F2 Set 80 char limit
nnoremap <silent> <F2> :execute "set colorcolumn=" . (&colorcolumn == "" ? "81" : "")<CR>

" F3 Show whitespaces
set listchars=space:·,eol:¬,tab:▸\ ,trail:~,precedes:«,extends:»
nnoremap <silent> <F3> :set list!<CR>


" Plugins
"
" Add pacman-installed vim plugins
set runtimepath+=/usr/share/vim/vimfiles

" FZF plugin
nnoremap gy :FZF<CR>

" Signify plugin
set updatetime=100

" Simplenote plugin
" let g:SimplenoteUsername = "..."
" let g:SimplenotePassword = "..."
source ~/.simplenoterc
nnoremap ss :SimplenoteList<cr>
nnoremap su :SimplenoteUpdate<cr>


" Especific files
"
" C files
augroup filetype_c
	autocmd!
	autocmd Filetype c setlocal commentstring=//\ %s
augroup END

" Cpp files
augroup filetype_cpp
	autocmd!
	autocmd Filetype c setlocal commentstring=//\ %s
augroup END

" Python files
augroup filetype_python
	autocmd!
	autocmd Filetype python setlocal expandtab
augroup END

" Java files
augroup filetype_java
	autocmd!
	autocmd Filetype java setlocal expandtab
augroup END
