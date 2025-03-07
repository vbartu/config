local M = {}

function M.file_name()
    local full_name = vim.api.nvim_buf_get_name(0)
    return full_name:match("[^/]*$")
end

function M.to_clipboard(str)
    vim.fn.setreg("+", str )
end

function M.fzf_with_input(str)
    require("fzf-lua").files({query=str})
end

function M.tmux_tab_cmd(cmd)
    vim.cmd("!tmux split-window -v " .. cmd)
end

function M.launch_python_code(code)
    local tmp_file = os.tmpname()
    local tmp_handle = io.open(tmp_file, "w")
    if tmp_handle == nil then
        return
    end
    tmp_handle:write(code)
    tmp_handle:flush()
    tmp_handle:close()
    M.tmux_tab_cmd("python -i " .. tmp_file)
end

return M
