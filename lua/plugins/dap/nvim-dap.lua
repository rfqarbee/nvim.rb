return {
  "mfussenegger/nvim-dap",
  enabled = true,
  lazy = true,
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    "theHamsta/nvim-dap-virtual-text",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")
    local map = require("custom.utils").map

    require("dapui").setup()
    require("nvim-dap-virtual-text").setup({
      enabled = true,
    })

    -- test gdb
    dap.adapters.gdb = {
      type = "executable",
      command = "gdb",
      args = { "-i", "dap" },
    }

    dap.configurations.c = {
      {
        name = "Launch",
        type = "gdb",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopAtBeginningOfMainSubprogram = false,
      },
    }

    map("n", "<leader>b", function()
      dap.toggle_breakpoint()
    end, { desc = "Toggle breakpoint" })
    map("n", "<leader>dc", function()
      dap.run_to_cursor()
    end, { desc = "Run to cursor" })
    map("n", "<leader>?", function()
      dapui.eval(nil, { enter = true })
    end, { desc = "Eval dapui" })
    map("n", "<F1>", function()
      dap.continue()
    end, { desc = "Continue" })
    map("n", "<F2>", function()
      dap.step_into()
    end, { desc = "Step into" })
    map("n", "<F3>", function()
      dap.step_over()
    end, { desc = "Step over" })
    map("n", "<F4>", function()
      dap.step_out()
    end, { desc = "Step out" })
    map("n", "<F5>", function()
      dap.step_back()
    end, { desc = "Step back" })
    map("n", "<F6>", function()
      dap.restart()
    end, { desc = "Restart" })
    map("n", "<F7>", function()
      dap.run_last()
    end, { desc = "Restart" })
    map("n", "<F8>", function()
      dap.terminate()
    end, { desc = "Restart" })
    map("n", "<F9>", function()
      dap.disconnect({ terminateDebuggee = false })
    end, { desc = "Restart" })

    map("n", "<leader>do", function()
      dapui.toggle()
    end, { desc = "Dap-ui" })

    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end
  end,
}
