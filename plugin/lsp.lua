vim.pack.add({
  "https://github.com/rafamadriz/friendly-snippets",
  { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.*") },
  "https://github.com/neovim/nvim-lspconfig",
})

require("blink.cmp").setup({
  completion = {
    documentation = { auto_show = true, auto_show_delay_ms = 300 },
    list = { selection = { auto_insert = false } },
    menu = {
      draw = {
        columns = {
          { "label", "label_description", gap = 1 },
          { "kind_icon", "kind", gap = 1 },
        },
      },
    },
  },
})

local disable_semantic_tokens = {
  lua = true,
}

vim.lsp.enable({
  "clangd",
  "zls",
  "basedpyright",
  "omnisharp", -- monogame
  -- "vtsls", -- for work
  -- "vue_ls", -- for work
  "tailwindcss", -- for work
  "gopls", -- for work
  "lua_ls",
  -- "tsgo", -- experiment
  "svelte", -- personal
  "sqls",
})

vim.api.nvim_create_autocmd({ "LspAttach" }, {
  group = vim.api.nvim_create_augroup("neovim-lsp-group", { clear = true }),
  callback = function(event)
    local bufnr = event.buf
    local client = assert(vim.lsp.get_client_by_id(event.data.client_id), "Must have valid client")
    local fzf = require("fzf-lua")

    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Goto declaration" })
    vim.keymap.set("n", "grh", vim.lsp.buf.signature_help, { desc = "Signature help" })
    vim.keymap.set("n", "gO", fzf.lsp_document_symbols, { desc = "Document symbols" })
    vim.keymap.set("n", "grw", fzf.lsp_workspace_symbols, { desc = "Workspace symbols" })
    vim.keymap.set("n", "<leader>qw", function()
      vim.diagnostic.setqflist()
    end)
    vim.keymap.set("n", "<leader>qd", function()
      vim.diagnostic.setloclist()
    end)
    vim.keymap.set("n", "<leader>cx", function()
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
