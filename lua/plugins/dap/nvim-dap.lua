return {
  {
    "mfussenegger/nvim-dap",
    -- lazy = true,
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "theHamsta/nvim-dap-virtual-text",
    },
    keys = {
      { "<leader>do", "<cmd>lua require('dapui').toggle()<cr>", desc = "Dap Ui" },
    },
    config = function()
      local dap = require("dap")
      local map = require("custom.utils").map

      require("nvim-dap-virtual-text").setup({
        enabled = true,
      })

      dap.adapters.cppdbg = {
        id = "cppdbg",
        type = "executable",
        command = vim.fn.stdpath("data") .. "/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7",
      }
      -- test gdb
      -- dap.adapters.gdb = {
      --   type = "executable",
      --   command = "gdb",
      --   args = { "-i", "dap" },
      -- }
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
      -- js
      dap.adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "node",
          args = {
            vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
            "${port}",
          },
        },
      }

      dap.configurations.javascript = {
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          cwd = "${workspaceFolder}",
        },
      }

      map("n", "<leader>b", function()
        dap.toggle_breakpoint()
      end, { desc = "Dap: Toggle breakpoint" })
      map("n", "<leader>dc", function()
        dap.run_to_cursor()
      end, { desc = "Dap: Run to cursor" })
      map("n", "<F1>", function()
        dap.continue()
      end, { desc = "Dap: Continue" })
      map("n", "<F2>", function()
        dap.step_into()
      end, { desc = "Dap: Step into" })
      map("n", "<F3>", function()
        dap.step_over()
      end, { desc = "Dap: Step over" })
      map("n", "<F4>", function()
        dap.step_out()
      end, { desc = "Dap: Step out" })
      map("n", "<F5>", function()
        dap.step_back()
      end, { desc = "Dap: Step back" })
      map("n", "<F6>", function()
        dap.restart()
      end, { desc = "Dap: Restart" })
      map("n", "<F7>", function()
        dap.run_last()
      end, { desc = "Dap: Runlast" })
      map("n", "<F8>", function()
        dap.terminate()
      end, { desc = "Dap: terminate" })
      map("n", "<F9>", function()
        dap.disconnect({ terminateDebuggee = false })
      end, { desc = "Dap: disconnect" })
    end,
  },
}
