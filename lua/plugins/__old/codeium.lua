return {
  "Exafunction/codeium.vim",
  enabled = false,
  event = "BufEnter",
  config = function()
    vim.g.codeium_filetypes = { markdown = false }
  end,
}
