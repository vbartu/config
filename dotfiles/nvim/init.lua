vim.opt.encoding = "utf-8"
vim.opt.mouse = "a"
vim.g.mapleader = " "
vim.opt.hlsearch = true
vim.opt.number = true
vim.opt.cursorline = true
vim.wo.signcolumn = "yes"

-- Clipboard copy/paste
vim.keymap.set("n", ",d", "\"+d")
vim.keymap.set("n", ",y", "\"+y")
vim.keymap.set("n", ",p", "\"+p")
vim.keymap.set("v", ",d", "\"+d")
vim.keymap.set("v", ",y", "\"+y")
vim.keymap.set("v", ",p", "\"+p")
vim.g.clipboard = {
    name = 'OSC 52',
    copy = {
        ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
        ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
    },
    paste = {
        ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
        ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
    },
}

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
vim.keymap.set("n", "<Enter>", "<Nop>")

-- Shortcuts
local shortcuts_file = vim.fn.stdpath("config") .. "/nvim_shortcuts"
local dap_shortcuts_file = vim.fn.stdpath("config") .. "/nvim_dap_shortcuts"
vim.keymap.set("n", "<Leader>a", ":!cat " .. shortcuts_file .. "<CR>")
vim.keymap.set("n", "<Leader>m", ":!cat " .. dap_shortcuts_file .. "<CR>")
local function reopen(cmd)
    local pos = vim.api.nvim_win_get_cursor(0)
    vim.cmd(cmd .. " %:p")
    vim.api.nvim_win_set_cursor(0, pos)
end
vim.keymap.set("n", "<Leader>t", function() reopen("tabe") end)
vim.keymap.set("n", "<Leader>v", function() reopen("vsplit") end)

-- Misc mappings
vim.keymap.set("n", ",s", ":%s/\\<<C-r><C-w>\\>/")

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
-- Load extras
require("extras")

-- F2: Set 80 char limit
local char_limit = os.getenv("NVIM_CHAR_LIMIT") or "80"
vim.keymap.set("n", "<F2>", function()
    if #(vim.opt.colorcolumn:get()) == 0 then
        vim.opt.colorcolumn = {char_limit}
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
    "rhysd/git-messenger.vim",
    {"akinsho/toggleterm.nvim", version = "*", config = true},
    "ibhagwan/fzf-lua",
    "neovim/nvim-lspconfig",
    "Mofiqul/trld.nvim",
    "nmac427/guess-indent.nvim",
    "mfussenegger/nvim-dap",
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

-- Terminal
require("toggleterm").setup()
vim.keymap.set("t", "<ESC>", "<C-\\><C-n>")
vim.keymap.set("n", "<C-Space>", ":ToggleTerm direction=float<CR>")
vim.keymap.set("n", "<C-m>", ":ToggleTerm direction=horizontal size=20<CR>")
vim.keymap.set("n", "<C-n>", ":ToggleTerm direction=tab<CR>")

-- Allows vim-signify to update in realtime
vim.opt.updatetime = 100

-- Git Messenger (git blame)
vim.keymap.del("n", "<Leader>gm") -- default bindings
vim.keymap.set("n", "<Leader>b", ":GitMessenger<CR>")

-- FZF
local fzf = require("fzf-lua")
vim.keymap.set("n", "<Leader>f", fzf.files)
vim.keymap.set("n", "<Leader>s", fzf.lsp_document_symbols)
vim.keymap.set("n", "<Leader>S", fzf.lsp_workspace_symbols)
vim.keymap.set("n", "<Leader>g", fzf.live_grep)
vim.keymap.set("v", "<Leader>w", fzf.grep_visual)
vim.keymap.set("n", "<Leader>w", fzf.grep_cword)
vim.keymap.set("n", "<Leader>d", fzf.diagnostics_document)
vim.keymap.set("n", "<Leader>r", fzf.resume)

vim.keymap.set("n", ",p", fzf.registers)
vim.keymap.set("n", ",j", fzf.jumps)
vim.keymap.set("n", ",:", fzf.command_history)
vim.keymap.set("n", ",/", fzf.search_history)

-- TreeSitter
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = {"c", "lua", "vim", "vimdoc", "query", "python", "rust"},
  highlight = {enable = true},
}

-- LSP
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        -- Buffer local mappings.
        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'gD', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'ge', fzf.lsp_typedefs, opts)
        vim.keymap.set('n', 'gr', fzf.lsp_references, opts)
        vim.keymap.set('n', ',r', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', ',k', vim.lsp.buf.hover, opts)
    end
})

vim.lsp.enable({"clangd", "pyright", "rust_analyzer", "lua_ls", "tacc"})

-- Diagnostics
require("diagnostics")

-- Autocompletion
require("autocompletion")

-- DAP
require("dap_config")

-- Arista
require("arista")
