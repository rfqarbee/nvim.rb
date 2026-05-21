local capabilities = require("blink.cmp").get_lsp_capabilities()
return {
  filetypes = { "cs", "vb" },
  capabilities = capabilities,
  settings = {
    RoslynExtensionsOptions = {
      EnableAnalyzersSupport = true,
      EnableImportCompletion = true,
      AnalyzeOpenDocumentsOnly = true,
      EnableDecompilationSupport = true,
    },
  },
}
