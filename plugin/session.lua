vim.pack.add({ "https://github.com/rmagatti/auto-session" })

require("auto-session").setup({
  suppressed_dirs = { "~/", "~/Downloads", "/" },
  git_use_branch_name = true,
  purge_after_minutes = 10080,
  session_lens = {
    picker = "fzf",
    mappings = {
      delete_session = { "i", "<C-x>" },
      alternate_session = { "i", "<C-s>" },
      copy_session = { "i", "<C-y>" },
    },
  },
})

vim.keymap.set("n", "<leader>wr", "<cmd>AutoSession search<CR>")
vim.keymap.set("n", "<leader>wd", "<cmd>AutoSession deletePicker<CR>")
vim.keymap.set("n", "<leader>wp", "<cmd>AutoSession save<CR>")
