return {
  "folke/trouble.nvim",
  opts = {
    focus = true,
    preview = {
      border = "none"
    }
  },
  cmd = "Trouble",
  keys = {
    {
      "<leader>qw",
      "<cmd>Trouble diagnostics toggle<cr>",
      desc = "Diagnostics (Trouble)",
    },
    {
      "<leader>qd",
      "<cmd>Trouble diagnostics toggle filter.buf=0 <cr>",
      desc = "Buffer Diagnostics (Trouble)",
    },
    {
      "<leader>qL",
      "<cmd>Trouble loclist toggle <cr>",
      desc = "Location List (Trouble)",
    },
    {
      "<leader>ql",
      "<cmd>Trouble qflist toggle <cr>",
      desc = "Quickfix List (Trouble)",
    },
  },
}
