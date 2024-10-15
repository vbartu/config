local dap = require("dap")
local widgets = require("dap.ui.widgets")

dap.defaults.fallback.terminal_win_cmd = 'tabnew'

-- dap.defaults.fallback.external_terminal = {
--   command = '/usr/bin/alacritty';
--   args = {'-e'};
-- }
-- dap.defaults.fallback.force_external_terminal = true


local hover_widget = nil
function toggle_hover()
  if hover_widget == nil then
    hover_widget = widgets.hover()
  else
    hover_widget.close()
    hover_widget = nil
  end
end

function step_over_i () dap.step_over({steppingGranularity="instruction"}) end
function step_into_i () dap.step_into({steppingGranularity="instruction"}) end

vim.keymap.set("n", "mb", dap.toggle_breakpoint)
vim.keymap.set("n", "ml", dap.list_breakpoints)
vim.keymap.set("n", "mo", dap.clear_breakpoints)
vim.keymap.set("n", "mc", dap.continue)
vim.keymap.set("n", "mp", dap.pause)
vim.keymap.set("n", "mt", dap.close)
vim.keymap.set("n", "mn", dap.step_over)
vim.keymap.set("n", "ms", dap.step_into)
vim.keymap.set("n", "mni", step_over_i )
vim.keymap.set("n", "msi", step_into_i )
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

-- C/C++
dap.adapters.cppdbg = {
  id = "cppdbg",
  type = "executable",
  command = "OpenDebugAD7",
}

dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "cppdbg",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopAtEntry = true,
  },
  {
    name = 'Attach to gdbserver :1234',
    type = 'cppdbg',
    request = 'launch',
    MIMode = 'gdb',
    miDebuggerServerAddress = 'localhost:1234',
    miDebuggerPath = '/usr/bin/gdb',
    cwd = '${workspaceFolder}',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
  },
}

dap.configurations.c = dap.configurations.cpp
