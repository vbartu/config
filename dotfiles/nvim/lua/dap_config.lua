local dap = require("dap")
local widgets = require("dap.ui.widgets")

local hover_widget = nil
function toggle_hover()
  if hover_widget == nil then
    hover_widget = widgets.hover()
  else
    hover_widget.close()
    hover_widget = nil
  end
end

vim.keymap.set("n", "mb", dap.toggle_breakpoint)
vim.keymap.set("n", "ml", dap.list_breakpoints)
vim.keymap.set("n", "mo", dap.clear_breakpoints)
vim.keymap.set("n", "mc", dap.continue)
vim.keymap.set("n", "mp", dap.pause)
vim.keymap.set("n", "mt", dap.close)
vim.keymap.set("n", "mn", dap.step_over)
vim.keymap.set("n", "ms", dap.step_into)
vim.keymap.set("n", "mf", dap.step_out)
vim.keymap.set("n", "mz", dap.run_to_cursor)
vim.keymap.set("n", "mr", dap.repl.toggle)
vim.keymap.set("n", "mk", toggle_hover)
-- TODO: :help dap.txt widget api

-- Python
dap.adapters.python = function(cb, config)
  if config.request == "attach" then
    local port = (config.connect or config).port
    local host = (config.connect or config).host or "127.0.0.1"
    cb({
      type = "server",
      port = assert(
        port,
        "`connect.port` is required for a python `attach` configuration"
      ),
      host = host,
      options = {
        source_filetype = "python",
      },
    })
  else -- "launch"
    cb({
      type = "executable",
      command = "python",
      args = { "-m", "debugpy.adapter" },
      options = {
        source_filetype = "python",
      },
    })
  end
end

dap.configurations.python = {
  {
    type = "python";
    request = "launch";
    name = "Launch file";
    -- Options below are for debugpy
    program = "${file}";
  },
}
