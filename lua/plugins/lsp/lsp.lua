return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
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

      require("mason").setup()

      local ensure_installed = {
        "gopls",
        "lua_ls",
        "csharp_ls",
        "vtsls"
      }

      local function iscx()
        local dir = vim.fn.fnamemodify(vim.fn.getcwd(0), ":~:p:h")
        local match = string.find(dir, 'contract')
        if match == nil then
          return true
        else
          return false
        end
      end


      require("mason-lspconfig").setup({
        ensure_installed = ensure_installed,
        automatic_enable = iscx()
      })

      local disable_semantic_tokens = {
        lua = true,
      }

      vim.api.nvim_create_autocmd({ "LspAttach" }, {
        group = vim.api.nvim_create_augroup("neovim-lsp-group", { clear = true }),
        callback = function(event)
          local bufnr = event.buf
          local client = assert(vim.lsp.get_client_by_id(event.data.client_id), "Must have valid client")
          local fzf = require("fzf-lua")

          map("n", "<leader>li", function()
            local ts = vim.lsp.get_clients({ name = "vtsls" })[1]
            if ts then
              return ts:exec_cmd(
                {
                  title = "Remove unsued",
                  command = "typescript.removedUnusedImports",
                  arguments = { vim.api.nvim_get_current_buf() }
                },
                { bufnr = bufnr })
            end
          end, { desc = "lsp organize ?" })
          map("n", "<leader>lo", function()
            local ts = vim.lsp.get_clients({ name = "vtsls" })[1]
            if ts then
              return ts:exec_cmd(
                {
                  title = "Organize Imports",
                  command = "typescript.organizeImports",
                  arguments = { vim.api.nvim_get_current_buf() }
                },
                { bufnr = bufnr })
            end
          end, { desc = "lsp organize" })
          map("n", "gd", vim.lsp.buf.definition, { desc = "Goto defintion" })
          map("n", "gD", vim.lsp.buf.declaration, { desc = "Goto declaration" })
          map("n", "grh", vim.lsp.buf.signature_help, { desc = "Signature help" })
          map("n", "grs", fzf.lsp_document_symbols, { desc = "Document symbols" })
          map("n", "grd", fzf.lsp_typedefs, { desc = "Type definition" })
          map("n", "grw", fzf.lsp_workspace_symbols, { desc = "Workspace symbols" })
          map("n", "<M-e>", function()
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
  },
}
