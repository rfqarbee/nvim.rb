-- replaces vim.lsp.buf.definition()
vim.keymap.set("n", "gd", function()
  require("omnisharp_extended").lsp_definition()
end, { desc = "omnisharp gd", noremap = true })

-- replaces vim.lsp.buf.type_definition()
vim.keymap.set("n", "grd", function()
  require("omnisharp_extended").lsp_type_definition()
end, { desc = "omnisharp type defs", noremap = true })

-- replaces vim.lsp.buf.references()
vim.keymap.set("n", "grr", function()
  require("omnisharp_extended").lsp_references()
end, { desc = "omnisharp references", noremap = true })

-- replaces vim.lsp.buf.implementation()
vim.keymap.set("n", "gI", function()
  require("omnisharp_extended").lsp_implementation()
end, { desc = "omnisharp implementation", noremap = true })
