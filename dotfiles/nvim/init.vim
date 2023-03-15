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


" Number and cursorline
set number
set cursorline


" Tab default config
set expandtab
set tabstop=4
set shiftwidth=4
set shiftround " shift indent to shiftwdth multiple
inoremap <S-Tab> <C-d>


" Navigation
set splitright
set splitbelow
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-H> <C-W><C-H>
nnoremap <C-L> <C-W><C-L>
nnoremap H ^
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

" F4 Enable autocomplete
let g:cmp_enable = v:false
function! ToggleAutocomplete()
   if g:cmp_enable
      let g:cmp_enable = v:false
      set signcolumn=auto
      set completeopt=menu,preview
   else
      let g:cmp_enable = v:true
      set signcolumn=auto:2
      set completeopt=menuone,noinsert,noselect
   endif
endfunction
nnoremap <F4> :call ToggleAutocomplete()<CR>


" Especific files

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


" Plugins

" Add pacman-installed vim plugins
set runtimepath+=/usr/share/vim/vimfiles

" Plug
call plug#begin()
Plug 'EdenEast/nightfox.nvim', { 'tag': 'v1.0.0' }

Plug 'mhinz/vim-signify'
Plug 'simplenote-vim/simplenote.vim'
Plug 'tpope/vim-commentary'

" LSP & autocomplete
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'

Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/cmp-vsnip'
call plug#end()
colorscheme nightfox
" colorscheme dayfox

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

" Errors select
"autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })


" LSP
nnoremap <silent> 99         <cmd>lua vim.diagnostic.open_float(nil, { focusable = false })<CR>
nnoremap <silent> gd         <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K          <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gi         <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k>      <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> <space>D   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr         <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0         <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW         <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> <space>rn  <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <space>f   <cmd>lua vim.lsp.buf.formatting()<CR>
nnoremap <silent> ga         <cmd>lua vim.lsp.buf.code_action()<CR>

lua << EOF
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
local lspconfig = require('lspconfig')

local servers = { 'rust_analyzer' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    capabilities = capabilities,
  }
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
    signs = true,
    update_in_insert = true,
  }
)

local cmp = require('cmp')
cmp.setup({
  enabled = function()
    return vim.g.cmp_enable
  end,
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'buffer' },
  },
})
EOF
