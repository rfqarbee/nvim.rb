return {
  "folke/trouble.nvim",
  enabled = true,
  cmd = "Trouble",
  keys = {
    { "<leader>qd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Current diagnostics" },
    { "<leader>qw", "<cmd>Trouble diagnostics toggle<cr>", desc = "Project diagnostics" },
    { "<M-]>", "<cmd>Trouble diagnostics next focus=1<cr>", desc = "Project diagnostics" },
    { "<M-[>", "<cmd>Trouble diagnostics prev focus=1<cr>", desc = "Project diagnostics" },
  },
  opts = {
    auto_close = true,
    focus = false,
    warn_no_results = true,
    open_no_results = false,
    follow = true,
    win = {
      size = 45,
      position = "right",
    },
    modes = {
      diagnostics = {
        mode = "diagnostics",
        win = { size = 12, position = "bottom" },
      },
    },
  },
}
