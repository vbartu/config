local trld = require("trld")
trld.setup({})
vim.diagnostic.config({
  virtual_text = false,
  underline = {severity = vim.diagnostic.severity.WARN},
  severity_sort = true,
})
vim.keymap.set("n", ",e", vim.diagnostic.open_float)


local function toggle_diagnostics()
  if vim.diagnostic.is_enabled() then
    vim.cmd("autocmd! CursorHold,CursorHoldI *")
    vim.cmd("autocmd! CursorMoved,CursorMovedI *")
    vim.diagnostic.enable(false)
    print("Diagnostics disabled")
  else
    trld.setup({})
    vim.diagnostic.enable()
    print("Diagnostics enabled")
  end
end

vim.keymap.set("n", "<F4>", toggle_diagnostics)
