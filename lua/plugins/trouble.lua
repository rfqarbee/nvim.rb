return {
  "folke/trouble.nvim",
  enabled = true,
  cmd = "Trouble",
  keys = {
    { "<leader>qd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", "Current diagnostics" },
    { "<leader>qw", "<cmd>Trouble diagnostics toggle<cr>", "Project diagnostics" },
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
      diagnostics = {
        mode = "diagnostics",
        win = { size = 12, position = "bottom" },
      },
    },
  },
}
