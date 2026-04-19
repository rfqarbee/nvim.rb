vim.pack.add({
  "https://github.com/mfussenegger/nvim-dap",
  "https://github.com/rcarriga/nvim-dap-ui",
  "https://github.com/nvim-neotest/nvim-nio",
  "https://github.com/theHamsta/nvim-dap-virtual-text",
})
require("dapui").setup()
local dap = require("dap")

require("nvim-dap-virtual-text").setup({
  enabled = true,
})

--dotnet
dap.adapters.coreclr = {
  type = "executable",
  command = vim.fn.stdpath("data") .. "/mason/packages/netcoredbg/netcoredbg",
  args = { "--interpreter=vscode" },
}
dap.configurations.cs = {
  {
    type = "coreclr",
    name = "launch - netcoredbg",
    request = "launch",
    program = function()
      return vim.fn.input("Path to dll", vim.fn.getcwd() .. "/", "file")
    end,
  },
}

dap.adapters.cppdbg = {
  id = "cppdbg",
  type = "executable",
  command = vim.fn.stdpath("data") .. "/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7",
}
dap.configurations.c = {
  {
    name = "Launch",
    type = "cppdbg",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopAtEntry = true,
  },
  {
    name = "Attach to gdbserver :1234",
    type = "cppdbg",
    request = "launch",
    MIMode = "gdb",
    miDebuggerServerAddress = "localhost:1234",
    miDebuggerPath = "/usr/bin/gdb",
    cwd = "${workspaceFolder}",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
  },
}

vim.keymap.set("n", "<leader>b", function()
  dap.toggle_breakpoint()
end, { desc = "Dap: Toggle breakpoint" })
vim.keymap.set("n", "<leader>dc", function()
  dap.run_to_cursor()
end, { desc = "Dap: Run to cursor" })
vim.keymap.set("n", "<F1>", function()
  dap.continue()
end, { desc = "Dap: Continue" })
vim.keymap.set("n", "<F2>", function()
  dap.step_into()
end, { desc = "Dap: Step into" })
vim.keymap.set("n", "<F3>", function()
  dap.step_over()
end, { desc = "Dap: Step over" })
vim.keymap.set("n", "<F4>", function()
  dap.step_out()
end, { desc = "Dap: Step out" })
vim.keymap.set("n", "<F5>", function()
  dap.step_back()
end, { desc = "Dap: Step back" })
vim.keymap.set("n", "<F6>", function()
  dap.restart()
end, { desc = "Dap: Restart" })
vim.keymap.set("n", "<F7>", function()
  dap.run_last()
end, { desc = "Dap: Runlast" })
vim.keymap.set("n", "<F8>", function()
  dap.terminate()
end, { desc = "Dap: terminate" })
vim.keymap.set("n", "<F9>", function()
  dap.disconnect({ terminateDebuggee = false })
end, { desc = "Dap: disconnect" })
