return {
  "Exafunction/codeium.vim",
  enabled = true,
  event = "BufEnter",
  config = function()
    vim.g.codeium_filetypes = { markdown = false }
  end,
}
