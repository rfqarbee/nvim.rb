vim.api.nvim_set_keymap("n", "<leader>kk", ":lua require('kulala').jump_prev()<CR>",
  { noremap = true, silent = true, desc = "Jump previous Req" })
vim.api.nvim_set_keymap("n", "<leader>kj", ":lua require('kulala').jump_next()<CR>",
  { noremap = true, silent = true, desc = "Jump next Req" })
vim.api.nvim_set_keymap("n", "<leader>kr", ":lua require('kulala').run()<CR>",
  { noremap = true, silent = true, desc = "Run http request" })
