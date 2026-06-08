vim.pack.add({
  "https://github.com/Hoffs/omnisharp-extended-lsp.nvim",
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/windwp/nvim-ts-autotag",
  "https://github.com/NMAC427/guess-indent.nvim",
  "https://github.com/mbbill/undotree",
  "https://github.com/cbochs/grapple.nvim",
  "https://github.com/nvim-mini/mini.ai",
  "https://github.com/nvim-mini/mini.surround",
})
-- Use `<Leader>ls` and `<Leader>lS` for incremental selection
local copy_keymap = function(mode, from_lhs, to_lhs)
  local keymap = vim.fn.maparg(from_lhs, mode, false, true)
  local rhs = keymap.callback or keymap.rhs
  vim.keymap.set(mode, to_lhs, rhs, { desc = keymap.desc })
end
copy_keymap("x", "an", "<Leader>ls")
copy_keymap("x", "in", "<Leader>lS")
require("nvim-web-devicons").setup({})
require("nvim-ts-autotag").setup()
require("mini.surround").setup()
require("mini.ai").setup()

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
