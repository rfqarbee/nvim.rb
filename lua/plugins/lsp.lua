return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
  },
  config = function()
    local capabilities = require("blink.cmp").get_lsp_capabilities()
    local signs = require("custom.icons").lsp_signs
    local map = require("custom.utils").map
    vim.diagnostic.config({
      underline = true,
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = signs.Error,
          [vim.diagnostic.severity.WARN] = signs.Warn,
          [vim.diagnostic.severity.INFO] = signs.Info,
          [vim.diagnostic.severity.HINT] = signs.Hint,
        },
      },
    })
    require("mason").setup({})

    local disable_semantic_tokens = {
      lua = true,
    }

    vim.lsp.config("omnisharp", {
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
    })

    vim.lsp.config("vtsls", {
      filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact", "vue" },
      root_markers = {
        {
          "tsconfig.json",
          "package.json",
          "pnpm-lock.yaml",
        },
        ".git",
      },
      settings = {
        vtsls = {
          tsserver = {
            globalPlugins = {
              {
                name = "@vue/typescript-plugin",
                location = vim.fn.stdpath("data")
                  .. "/mason/packages/vue-language-server/node_modules/@vue/language-server",
                languages = { "vue" },
                configNamespace = "typescript",
              },
            },
          },
        },
      },
    })

    vim.lsp.enable("omnisharp")
    vim.lsp.enable("tailwindcss")
    vim.lsp.enable("clangd")
    vim.lsp.enable("gopls")
    vim.lsp.enable("lua_ls")
    vim.lsp.enable("svelte")
    vim.lsp.enable("vtsls")
    vim.lsp.enable("vue_ls")

    vim.api.nvim_create_autocmd({ "LspAttach" }, {
      group = vim.api.nvim_create_augroup("neovim-lsp-group", { clear = true }),
      callback = function(event)
        local bufnr = event.buf
        local client = assert(vim.lsp.get_client_by_id(event.data.client_id), "Must have valid client")
        local fzf = require("fzf-lua")

        if client.name ~= "omnisharp" then
          map("n", "gd", vim.lsp.buf.definition, { desc = "Goto defintion" })
          map("n", "grd", fzf.lsp_typedefs, { desc = "Type definition" })
          map("n", "grr", vim.lsp.buf.references, { desc = "References" })
          map("n", "gI", vim.lsp.buf.implementation, { desc = "References" })
        end
        map("n", "gD", vim.lsp.buf.declaration, { desc = "Goto declaration" })
        map("n", "grh", vim.lsp.buf.signature_help, { desc = "Signature help" })
        map("n", "gO", fzf.lsp_document_symbols, { desc = "Document symbols" })
        map("n", "grw", fzf.lsp_workspace_symbols, { desc = "Workspace symbols" })
        map("n", "<leader>qw", function()
          vim.diagnostic.setqflist()
        end)
        map("n", "<leader>qd", function()
          vim.diagnostic.setloclist()
        end)
        map("n", "<leader>cx", function()
          vim.diagnostic.open_float({ border = "rounded", source = "if_many" })
        end, { desc = "Diagnostics open float" })

        local filetype = vim.bo[bufnr].filetype
        if disable_semantic_tokens[filetype] then
          client.server_capabilities.semanticTokensProvider = nil
        end

        if client and client.server_capabilities.documentHighlightProvider then
          vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            buffer = bufnr,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            buffer = bufnr,
            callback = vim.lsp.buf.clear_references,
          })
        end
      end,
    })
  end,
}
