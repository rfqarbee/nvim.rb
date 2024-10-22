return {
  "NeogitOrg/neogit",
  enabled = false,
  dependencies = {
    "nvim-lua/plenary.nvim", -- required
    "sindrets/diffview.nvim", -- optional - Diff integration
    "nvim-telescope/telescope.nvim",
  },
  keys = {
    { "<leader>nf", "<cmd>Neogit cwd=%:p:h<cr>", desc = "Git status (File Path)" },
    { "<leader>ns", "<cmd>Neogit<cr>", desc = "Git Status (Root)" },
    { "<leader>nd", "<cmd>Neogit diff<cr>", desc = "Neogit Diff" },
  },
  opts = {
    disable_line_numbers = false,
    disable_signs = true,
  },
}
