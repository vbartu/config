local M = {}

function M.basename()
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

function M.command_actions(commands)
    local items = {}
    for _, cmd in ipairs(commands) do
        for _, sub in ipairs(vim.fn.getcompletion(cmd .. " ", "cmdline")) do
            table.insert(items, cmd .. " " .. sub)
        end
    end
    table.sort(items)
    require("fzf-lua").fzf_exec(items, {
        prompt = "Actions > ",
        actions = {
            ["default"] = function(selected)
                local ok, err = pcall(vim.cmd, selected[1])
                if not ok then vim.notify(err, vim.log.levels.WARN) end
            end,
        },
    })
end

return M
