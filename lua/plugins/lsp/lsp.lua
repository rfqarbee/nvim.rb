return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    local signs = require("custom.icons").lsp_signs
    vim.diagnostic.config({
      underline = true,
      virtual_text = true,
      -- virtual_lines = { current_line = true },
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
        local client = assert(vim.lsp.get_client_by_id(event.data.client_id), "must have valid client")
        local fzf = require("fzf-lua")
        local map = function(keys, func, desc)
          vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
        end

        map("<leader>li", function()
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
        end, "lsp organize ?")
        map("<leader>lo", function()
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
        end, "lsp organize")
        map("gd", vim.lsp.buf.definition, "Goto defintion")
        map("gD", vim.lsp.buf.declaration, "Goto declaration")
        map("gr", vim.lsp.buf.references, "Goto references")
        map("gI", vim.lsp.buf.implementation, "Goto implementation")
        map("<leader>sh", vim.lsp.buf.signature_help, "Signature help")
        map("<leader>ld", fzf.lsp_typedefs, "Type definition")
        map("<leader>sd", fzf.lsp_document_symbols, "Document symbols")
        map("<leader>lw", fzf.lsp_workspace_symbols, "Workspace symbols")
        map("<leader>rn", vim.lsp.buf.rename, "Rename var")
        map("<leader>ca", vim.lsp.buf.code_action, "Code action")
        map("<M-e>", function()
          vim.diagnostic.open_float({ border = "rounded", source = "if_many" })
        end, "Diagnostics open float")
        map("<leader>lh", function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
        end, "InlayHints")

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
