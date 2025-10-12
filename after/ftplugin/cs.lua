-- replaces vim.lsp.buf.definition()
vim.keymap.set("gd", "<cmd>lua require('omnisharp_extended').lsp_definition()<cr>")

-- replaces vim.lsp.buf.type_definition()
vim.keymap.set("grd", "<cmd>lua require('omnisharp_extended').lsp_type_definition()<cr>")

-- replaces vim.lsp.buf.references()
vim.keymap.set("gr", "<cmd>lua require('omnisharp_extended').lsp_references()<cr>")

-- replaces vim.lsp.buf.implementation()
vim.keymap.set("gi", "<cmd>lua require('omnisharp_extended').lsp_implementation()<cr>")
