-- replaces vim.lsp.buf.definition()
vim.keymap.set("n", "gd", "<cmd>lua require('omnisharp_extended').lsp_definition()<cr>")

-- replaces vim.lsp.buf.type_definition()
vim.keymap.set("n", "grd", "<cmd>lua require('omnisharp_extended').lsp_type_definition()<cr>")

-- replaces vim.lsp.buf.references()
vim.keymap.set("n", "gr", "<cmd>lua require('omnisharp_extended').lsp_references()<cr>")

-- replaces vim.lsp.buf.implementation()
vim.keymap.set("n", "gi", "<cmd>lua require('omnisharp_extended').lsp_implementation()<cr>")
