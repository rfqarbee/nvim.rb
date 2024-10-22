return {
  "mfussenegger/nvim-dap",
  lazy = true,
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    "theHamsta/nvim-dap-virtual-text",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    require("dapui").setup({
      layouts = {
        -- Changing the layout order will give more space to the first element
        {
          -- You can change the order of elements in the sidebar
          elements = {
            -- { id = "scopes", size = 0.25, },
            { id = "stacks", size = 0.50 },
            { id = "breakpoints", size = 0.25 },
            { id = "watches", size = 0.25 },
          },
          size = 56,
          position = "right", -- Can be "left" or "right"
        },
        {
          elements = {
            { id = "repl", size = 0.60 },
            { id = "console", size = 0.50 },
          },
          size = 10,
          position = "bottom", -- Can be "bottom" or "top"
        },
      },
      controls = {
        icons = {
          pause = "",
          play = " (F1)",
          step_into = " (F2)",
          step_over = " (F3)",
          step_out = " (F4)",
          step_back = " (F5)",
          run_last = " (F7)",
          terminate = " (F8)",
          disconnect = " (F9)",
        },
      },
    })
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

    --[[
-- gdb via vscode cpptools
dap.adapters.cppdbg = {
	id = "cppdbg",
	type = "executable",
	command = "/home/rafiq/repos/vsix/extension/debugAdapters/bin/OpenDebugAD7",
}

dap.configurations.cpp = {
	{
		name = "Launch file",
		type = "cppdbg",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
		stopAtEntry = true,
		linux = {
			MiMode = "gdb",
			miDebuggerPath = "/usr/bin/gdb",
		},
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

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp
--]]

    vim.keymap.set("n", "<leader>b", function()
      dap.toggle_breakpoint()
    end, { desc = "Toggle breakpoint" })
    vim.keymap.set("n", "<leader>dc", function()
      dap.run_to_cursor()
    end, { desc = "Run to cursor" })
    vim.keymap.set("n", "<leader>?", function()
      dapui.eval(nil, { enter = true })
    end, { desc = "Eval dapui" })
    vim.keymap.set("n", "<F1>", function()
      dap.continue()
    end, { desc = "Continue" })
    vim.keymap.set("n", "<F2>", function()
      dap.step_into()
    end, { desc = "Step into" })
    vim.keymap.set("n", "<F3>", function()
      dap.step_over()
    end, { desc = "Step over" })
    vim.keymap.set("n", "<F4>", function()
      dap.step_out()
    end, { desc = "Step out" })
    vim.keymap.set("n", "<F5>", function()
      dap.step_back()
    end, { desc = "Step back" })
    vim.keymap.set("n", "<F6>", function()
      dap.restart()
    end, { desc = "Restart" })
    vim.keymap.set("n", "<F7>", function()
      dap.run_last()
    end, { desc = "Restart" })
    vim.keymap.set("n", "<F8>", function()
      dap.terminate()
    end, { desc = "Restart" })
    vim.keymap.set("n", "<F9>", function()
      dap.disconnect({ terminateDebuggee = false })
    end, { desc = "Restart" })

    vim.keymap.set("n", "<leader>dd", function()
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
