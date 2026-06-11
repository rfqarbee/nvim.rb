vim.pack.add({
  "https://github.com/neogitorg/neogit",
  "https://github.com/esmuellert/codediff.nvim",
  -- "m00qek/baleia.nvim",
})

require("neogit").setup({
  graph_style = "unicode",
  disable_line_numbers = false,
  disable_relative_line_numbers = false,
  disable_insert_on_commit = true,
})
vim.keymap.set("n", "gs", "<cmd>Neogit<cr>", { desc = "Open Neogit UI" })
