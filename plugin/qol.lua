vim.pack.add({
  "https://github.com/NMAC427/guess-indent.nvim",
  "https://github.com/mbbill/undotree",
  { src = "https://github.com/kylechui/nvim-surround", version = vim.version.range("4.x") },
})

vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
vim.g.undotree_SetFocusWhenToggle = 1
vim.g.undotree_WindowLayout = 2
vim.g.undotree_DiffpanelHeight = 15
