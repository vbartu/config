local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local fzf = require("fzf-lua")

-- Rust
lspconfig.rust_analyzer.setup({capabilities = capabilites})

-- C/C++
lspconfig.clangd.setup({capabilites = capabilites})
lspconfig.pyright.setup({capabilites = capabilites})

-- Python
lspconfig.ruff_lsp.setup({capabilites = capabilites})
require'lspconfig'.ruff_lsp.setup{
  init_options = {
    settings = {
      -- TODO: Change for select only modules
      args = {
          "--select=ALL",
          "--line-length=79",
          "--ignore=D,ANN,PLR,EM,TRY,COM,PTH,T20"},
    }
  }
}

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        -- Buffer local mappings.
        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'ge', fzf.lsp_typedefs, opts)
        vim.keymap.set('n', 'gr', fzf.lsp_references, opts)
        vim.keymap.set('n', ',r', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', ',k', vim.lsp.buf.hover, opts)
    end
})
