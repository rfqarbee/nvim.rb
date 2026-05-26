vim.pack.add({
  "https://github.com/Hoffs/omnisharp-extended-lsp.nvim",
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/windwp/nvim-ts-autotag",
  "https://github.com/NMAC427/guess-indent.nvim",
  "https://github.com/mbbill/undotree",
  { src = "https://github.com/kylechui/nvim-surround", version = vim.version.range("^3.0.0") },
  "https://github.com/cbochs/grapple.nvim",
})

require("nvim-web-devicons").setup({})
require("nvim-ts-autotag").setup()
require("nvim-surround").setup()

require("grapple").setup({
  scope = "git_branch",
})
vim.keymap.set("n", "<leader>a", require("grapple").toggle)
vim.keymap.set("n", "\\", require("grapple").toggle_tags)
vim.keymap.set("n", "<c-1>", "<cmd>Grapple select index=1<cr>")
vim.keymap.set("n", "<c-2>", "<cmd>Grapple select index=2<cr>")
vim.keymap.set("n", "<c-3>", "<cmd>Grapple select index=3<cr>")
vim.keymap.set("n", "<c-4->", "<cmd>Grapple select index=4<cr>")
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
vim.g.undotree_SetFocusWhenToggle = 1
vim.g.undotree_WindowLayout = 2
vim.g.undotree_DiffpanelHeight = 15
