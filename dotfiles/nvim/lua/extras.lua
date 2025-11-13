local utils = require("utils")


local function file_name_to_clipboard()
    local file_name = vim.api.nvim_buf_get_name(0)
    utils.to_clipboard(file_name)
end

vim.keymap.set("n", "<Leader>x", file_name_to_clipboard)

local function run_file_in_tmux_target()
    local handle = io.popen("cat /tmp/tmux_pane_target | tr '\n' ' '")
    if not handle then
        return
    end
    local pane_id = handle:read()
    local file_name = vim.api.nvim_buf_get_name(0)
    local file_cmd = "clear && ".. file_name
    -- local cmd = "tmux send-keys -t " .. pane_id .. " \"".. file_cmd .. "\" " .. "C-m"
    local cmd = string.format("tmux send-keys -t %s \"%s\" C-m", pane_id, file_cmd)
    os.execute(cmd)
    print("Running on pane " .. pane_id )
end

vim.keymap.set("n", "<Leader>z", run_file_in_tmux_target)
