vim.opt.encoding = "utf-8"
vim.opt.mouse = "a"
vim.g.mapleader = " "
vim.opt.hlsearch = true
vim.opt.number = true
vim.opt.cursorline = true
vim.wo.signcolumn = "yes"

-- Clipboard copy/paste
vim.keymap.set("n", "<Leader>d", "\"+d")
vim.keymap.set("n", "<Leader>y", "\"+y")
vim.keymap.set("n", "<Leader>p", "\"+p")
vim.keymap.set("v", "<Leader>d", "\"+d")
vim.keymap.set("v", "<Leader>y", "\"+y")
vim.keymap.set("v", "<Leader>p", "\"+p")

-- Tabs
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.shiftround = true -- Shift indent to shiftwidth multiple
vim.keymap.set("i", "<S-Tab>", "<C-d>")

-- Navigation
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.keymap.set("n", "<C-J>", "<C-W><C-J>")
vim.keymap.set("n", "<C-K>", "<C-W><C-K>")
vim.keymap.set("n", "<C-H>", "<C-W><C-H>")
vim.keymap.set("n", "<C-L>", "<C-W><C-L>")
vim.keymap.set("n", "H", "^")
vim.keymap.set("n", "L", "$")
vim.keymap.set("n", "<C-e>", "3<C-e>")
vim.keymap.set("n", "<C-y>", "3<C-y>")

-- Status line
vim.cmd([[
" Status line
autocmd WinLeave * highlight StatusModeColor ctermfg=15 ctermbg=239 cterm=Bold
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
]])


-- Functions
-- F2: Set 80 char limit
vim.keymap.set("n", "<F2>", function()
    if #(vim.opt.colorcolumn:get()) == 0 then
        vim.opt.colorcolumn = {"80"}
    else
        vim.opt.colorcolumn = {}
    end
end)

-- F3: Show whitespaces
vim.opt.listchars = {space = "·", eol = '↲', tab = '▸ ', trail = '~',
                     precedes = "«", extends = "»"}
vim.keymap.set("n", "<F3>", ":set list!<CR>", {silent = true})



-- Lazy nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    "EdenEast/nightfox.nvim",
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    "mhinz/vim-signify",
    "ibhagwan/fzf-lua",
    "neovim/nvim-lspconfig",
    "Mofiqul/trld.nvim",
    "nmac427/guess-indent.nvim",
    -- Completion
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-nvim-lsp",
    "saadparwaiz1/cmp_luasnip",
    "L3MON4D3/LuaSnip",
})

-- Plugins related config
vim.cmd("colorscheme nightfox")
require("guess-indent").setup({})

-- Allows vim-signify to update in realtime
vim.opt.updatetime = 100 

-- FZF
local fzf = require("fzf-lua")
vim.keymap.set("n", "<Leader>f", fzf.files)
vim.keymap.set("n", "<Leader>s", fzf.git_status)
vim.keymap.set("n", "<Leader>g", fzf.live_grep)
vim.keymap.set("v", "<Leader>v", fzf.grep_visual)
vim.keymap.set("n", "<Leader>w", fzf.grep_cword)

-- TreeSitter
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = {"c", "lua", "vim", "vimdoc", "query", "python", "rust"},
  highlight = {enable = true},
}


-- LSP
require("pylsp")
local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()
lspconfig.rust_analyzer.setup({capabilities = capabilites})
lspconfig.clangd.setup({capabilites = capabilites})

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', ',r', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', ',k', vim.lsp.buf.hover, opts)
    end
})

-- Diagnostics
-- Top-right corner diagnostic
require("trld").setup({})
vim.diagnostic.config({
    virtual_text = false,
    underline = {severity = vim.diagnostic.severity.WARN},
})
vim.keymap.set("n", ",e", vim.diagnostic.open_float)
vim.keymap.set("n", ",n", vim.diagnostic.goto_next)
vim.keymap.set("n", ",p", vim.diagnostic.goto_prev)
vim.keymap.set("n", ",q", vim.diagnostic.setloclist)

local function toggle_diagnostics()
	if vim.diagnostic.is_disabled() then
        vim.diagnostic.enable()
        print("Diagnostics enabled")
	else
        vim.diagnostic.disable()
        print("Diagnostics disabled")
	end
end
vim.keymap.set("n", "<F4>", toggle_diagnostics)


-- Autocompletion
local luasnip = require("luasnip")
local cmp = require("cmp")
cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
        ['<C-d>'] = cmp.mapping.scroll_docs(4), -- Down
        -- C-b (back) C-f (forward) for snippet placeholder navigation.
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
            cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
        else
            fallback()
        end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
            cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
        else
            fallback()
        end
    end, { 'i', 's' }),
  }),
  sources = {
    {name = "nvim_lsp"},
    {name = "luasnip"},
    {name = "buffer"},
  },
})

local cmp_enabled = true
local function toggle_autocompletion()
	if cmp_enabled then
		require("cmp").setup.buffer({ enabled = false })
		cmp_enabled = false
        print("Autocompletion disabled")
	else
		require("cmp").setup.buffer({ enabled = true })
		cmp_enabled = true
        print("Autocompletion enabled")
	end
end
