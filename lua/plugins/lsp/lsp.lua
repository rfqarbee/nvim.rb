return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    -- "WhoIsSethDaniel/mason-tool-installer.nvim",
    { "j-hui/fidget.nvim", opts = {} },
  },
  config = function()
    local capabilities = nil
    local lspconfig = require("lspconfig")
    local servers = require("plugins.lsp.config.customlsp").servers

    if pcall(require, "cmp_nvim_lsp") then
      capabilities = require("cmp_nvim_lsp").default_capabilities()
    end

    local signs = require("custom.icons").lsp_signs

    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end

    require("mason").setup()

    local ensure_installed = {
      "clangd",
      "csharp_ls",
      "gopls",
      "lua_ls",
      "ts_ls",
      "svelte",
      "prismals",
    }

    require("mason-lspconfig").setup({ ensure_installed = ensure_installed })

    for name, config in pairs(servers) do
      if config == true then
        config = {}
      end
      config = vim.tbl_deep_extend("force", {}, {
        capabilities = capabilities,
      }, config)

      lspconfig[name].setup(config)
    end

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

        -- map("<leader>li", ":OrganizeImports<cr>", "Ts organize import") -- TODO: ts_ls
        -- map("<leader>qd", vim.diagnostic.setqflist "test")
        map("gd", vim.lsp.buf.definition, "Goto defintion")
        map("gD", vim.lsp.buf.declaration, "Goto declaration")
        map("gr", vim.lsp.buf.references, "Goto references")
        map("gI", vim.lsp.buf.implementation, "Goto implementation")
        map("<leader>ld", fzf.lsp_typedefs, "Type definition")
        map("<leader>ls", fzf.lsp_document_symbols, "Document symbols")
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

        if client and client.server_capabilities.hoverProvider then
          vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
            border = "rounded",
          })
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
