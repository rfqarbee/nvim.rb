vim.api.nvim_create_autocmd("BufWinEnter", {
  group = vim.api.nvim_create_augroup("OpenHelp", { clear = true }),
  callback = function()
    local filetype = vim.bo.filetype
    if filetype == "help" then
      vim.keymap.set({ "n", "v" }, "q", "<cmd>q<cr>", { desc = "Quit help", buffer = true })
      vim.cmd("wincmd L")
      vim.cmd("vert resize 90")
    end
  end,
})
