vim.pack.add({
  "https://github.com/windwp/nvim-ts-autotag",
  "https://github.com/NMAC427/guess-indent.nvim",
  "https://github.com/mbbill/undotree",
  { src = "https://github.com/kylechui/nvim-surround", version = vim.version.range("4.x") },
})
-- Use `<Leader>ls` and `<Leader>lS` for incremental selection
local copy_keymap = function(mode, from_lhs, to_lhs)
  local keymap = vim.fn.maparg(from_lhs, mode, false, true)
  local rhs = keymap.callback or keymap.rhs
  vim.keymap.set(mode, to_lhs, rhs, { desc = keymap.desc })
end
copy_keymap("x", "an", "<Leader>ls")
copy_keymap("x", "in", "<Leader>lS")
require("nvim-ts-autotag").setup()

vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
vim.g.undotree_SetFocusWhenToggle = 1
vim.g.undotree_WindowLayout = 2
vim.g.undotree_DiffpanelHeight = 15
