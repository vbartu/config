local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local fzf = require("fzf-lua")

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

-- Rust
lspconfig.rust_analyzer.setup({capabilities = capabilites})

-- C/C++
lspconfig.clangd.setup({capabilites = capabilites})

-- Python
lspconfig.pyright.setup({capabilites = capabilites})
-- lspconfig.ruff_lsp.setup({capabilites = capabilites})
-- require'lspconfig'.ruff_lsp.setup{
--   init_options = {
--     settings = {
--       -- TODO: Change for select only modules
--       args = {
--           "--line-length=79",
--       },
--     }
--   }
-- }

-- Lua
lspconfig.lua_ls.setup({
  capabilites = capabilities,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = {
          'vim',
          'require'
        },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
    },
  },
})


-- TACC (Arista)
vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
    pattern = {'*.tac'},
    callback = function(ev)
        vim.lsp.start({
            name = 'tacc',
            cmd = {'/usr/bin/artaclsp'},
            -- cmd = {'/home/vbartual/.local/bin/artaclsp_logger'},
            cmd_args = {'-I', '/bld/'},
            root_dir = '/src',
        })
    end
})
