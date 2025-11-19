local function open_tin() -- Also for tac files
    local current_file = vim.api.nvim_buf_get_name(0)
    if current_file:sub(-3) == "tac" then
        local tin_file = current_file:sub(1, -4) .. "tin"
        if vim.fn.filereadable(tin_file) ~= 0  then
            print(tin_file)
            vim.cmd("vsplit " .. tin_file)
        else
            print("tin file does not exist")
        end
    elseif current_file:sub(-3) == "tin" then
        local tac_file = current_file:sub(1, -4) .. "tac"
        if vim.fn.filereadable(tac_file) ~= 0  then
            vim.opt.splitright = false
            vim.cmd("vsplit " .. tac_file)
            vim.opt.splitright = true
            print(tac_file)
        else
            print("tac file does not exist")
        end
    elseif current_file:sub(-1) == "h" then
        local cpp_file = current_file:sub(1, -2) .. "cpp"
        if vim.fn.filereadable(cpp_file) ~= 0  then
            print(cpp_file)
            vim.cmd("vsplit " .. cpp_file)
        else
            print("cpp file does not exist")
        end
    elseif current_file:sub(-3) == "hpp" then
        local cpp_file = current_file:sub(1, -4) .. "cpp"
        if vim.fn.filereadable(cpp_file) ~= 0  then
            print(cpp_file)
            vim.cmd("vsplit " .. cpp_file)
        else
            print("cpp file does not exist")
        end
    elseif current_file:sub(-3) == "cpp" then
        local h_file = current_file:sub(1, -4) .. "h"
        local hpp_file = current_file:sub(1, -4) .. "hpp"
        if vim.fn.filereadable(h_file) ~= 0  then
            vim.opt.splitright = false
            vim.cmd("vsplit " .. h_file)
            vim.opt.splitright = true
            print(h_file)
        elseif vim.fn.filereadable(hpp_file) ~= 0  then
            vim.opt.splitright = false
            vim.cmd("vsplit " .. hpp_file)
            vim.opt.splitright = true
            print(h_file)
        else
            print("h/hpp file does not exist")
        end
    else
        print("not a tac/tin or h/cpp pair")
    end
end

local function print_opengrok_link()
    local link_base = "https://opengrok.infra.corp.arista.io/source/xref/eos-trunk"
    local current_file = vim.api.nvim_buf_get_name(0)
    local line = vim.api.nvim_win_get_cursor(0)[1]
    print(link_base .. current_file .. "#" .. line)
end

vim.keymap.set("n", "<Leader>c", open_tin)
vim.keymap.set("n", "<Leader>o", print_opengrok_link)

vim.api.nvim_create_autocmd("FileType", {
    pattern = "tac",
    callback = function(event)
        local local_scope = {["scope"]="local"}
        vim.api.nvim_set_option_value("comments", "://", local_scope)
        vim.api.nvim_set_option_value("commentstring", "// %s", local_scope)
    end
})
