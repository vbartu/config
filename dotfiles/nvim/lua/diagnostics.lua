require("trld").setup({})
vim.diagnostic.config({
    virtual_text = false,
    underline = {severity = vim.diagnostic.severity.WARN},
    severity_sort = true,
})
vim.keymap.set("n", ",e", vim.diagnostic.open_float)


local function toggle_diagnostics()
	if vim.diagnostic.is_disabled() then
        vim.diagnostic.enable()
        print("Diagnostics enabled")
	else
        vim.diagnostic.disable()
        print("Diagnostics disabled")
	end
end

local M = {}
M.toggle_diagnostics = toggle_diagnostics

return M
