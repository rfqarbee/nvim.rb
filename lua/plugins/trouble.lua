return {
  "folke/trouble.nvim",
  enabled = true,
  dependencies = { "nvim-tree/nvim-web-devicons", "folke/lsp-colors.nvim" },
  cmd = "Trouble",
  keys = {
    { "<leader>qs", "<cmd>Trouble diag_priority toggle<cr>", "Project diagnostics on severity" },
    { "<leader>qd", "<cmd>Trouble diagnostics_buffer toggle<cr>", "Current diagnostics" },
    { "<leader>qw", "<cmd>Trouble diagnostics toggle<cr>", "Project diagnostics" },
    { "<leader>xn", "<cmd>Trouble todo toggle<cr>", "Todo list" },
    { "<leader>xq", "<cmd>Trouble quickfix toggle<cr>", "Toggle Quickfix list" },
    { "<leader>xl", "<cmd>Trouble loclist toggle<cr>", "Toggle Loclist list" },
    {
      "<leader>xs",
      "<cmd>Trouble symbols toggle pinned=true results.win.relative=win results.win.position=right<cr>",
      "Document Symbol list",
    },
    {
      "<leader>xS",
      "<cmd>Trouble lsp_document_symbols toggle<cr>",
      "Lsp Document symbols",
    },
    { "<leader>xd", "<cmd>Trouble lsp_definitions toggle<cr>", "Lsp Definition" },
    { "<leader>xD", "<cmd>Trouble lsp_declarations toggle<cr>", "Lsp Declaration" },
    { "<leader>xt", "<cmd>Trouble lsp toggle win.position=right<cr>", "Lsp" },
    { "[x", "<cmd>Trouble diagnostics_buffer next<cr>", "Next diagnostics" },
    { "]x", "<cmd>Trouble diagnostics_buffer prev<cr>", "Next diagnostics" },
  },
  opts = {
    focus = false,
    warn_no_results = false,
    open_no_results = false,
    follow = true,
    win = {
      size = 45,
      position = "right",
    },
    modes = {
      todo = {
        mode = "todo",
        win = { size = 40, position = "left" },
      },
      diagnostics = {
        mode = "diagnostics",
        win = { size = 12, position = "bottom" },
      },
      diagnostics_buffer = {
        desc = "Current Buffer diagnostics",
        mode = "diagnostics",
        filter = { buf = 0 },
        win = {
          position = "bottom",
          size = 12,
        },
      },
      diag_priority = {
        mode = "diagnostics",
        desc = "Diagnostics on severity",
        filter = function(items)
          local severity = vim.diagnostic.severity.HINT
          for _, item in ipairs(items) do
            severity = math.min(severity, item.severity)
          end
          return vim.tbl_filter(function(item)
            return item.severity == severity
          end, items)
        end,
        preview = {
          type = "split",
          relative = "win",
          position = "right",
          size = 0.5,
        },
        win = { position = "bottom", size = 10 },
      },
      quickfix = {
        mode = "quickfix",
        win = {
          position = "bottom",
          size = 12,
        },
      },
      diagnostics_project = {
        mode = "diagnostics",
        win = {
          position = "bottom",
          size = 12,
        },
        filter = {
          any = {
            buf = 0,
            {
              severity = vim.diagnostic.severity.ERROR,
              function(item)
                return item.filename:find((vim.loop or vim.uv).cwd(), 1, true)
              end,
            },
          },
        },
      },
    },
  },
}
