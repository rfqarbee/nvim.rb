return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    { "j-hui/fidget.nvim", opts = {} },
  },
  config = function()
    local lspconfig = require("lspconfig")
    local capabilities = nil
    local servers = require("plugins.lsp.config.customlsp").servers

    if pcall(require, "blink.cmp") then
      capabilities = require("blink.cmp").get_lsp_capabilities()
    end

    local signs = require("custom.icons").lsp_signs
    vim.diagnostic.config({
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
      "csharp_ls",
      "gopls",
      "lua_ls",
      "jdtls",
    }

    -- tools
    -- java-debug-tool
    -- java-test

    local masonlsp = require("mason-lspconfig")

    local handlers = {
      ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
      ["textDocument/signatureHelp"] = vim.lsp.with(
        vim.lsp.handlers.signature_help,
        { border = "rounded", title = "Signature Help" }
      ),
    }

    masonlsp.setup({ ensure_installed = ensure_installed })
    masonlsp.setup_handlers({
      -- automatic setup
      function(name)
        if name ~= "ts_ls" then
          lspconfig[name].setup({
            capabilities = capabilities,
            handlers = handlers,
          })
        end
      end,
    })

    -- custom setup
    for name, config in pairs(servers) do
      if config == true then
        config = {}
      end
      config = vim.tbl_deep_extend("force", {}, {
        capabilities = capabilities,
        handlers = handlers,
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
