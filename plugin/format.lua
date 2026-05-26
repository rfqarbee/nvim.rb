vim.pack.add({
  "https://github.com/stevearc/conform.nvim",
  "https://github.com/mfussenegger/nvim-lint",
})

require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    c = { "clang-format" },
    go = { "goimports", "gofumpt", stop_after_first = true },
    cs = { "csharpier" },
    css = { "prettierd", "prettier", stop_after_first = true },
    html = { "prettierd", "prettier", stop_after_first = true },
    vue = { "prettierd", "prettier", stop_after_first = true },
    svelte = { "prettierd", "prettier", stop_after_first = true },
    typescript = { "prettierd", "prettier", stop_after_first = true },
    typescriptreact = { "prettierd", "prettier", stop_after_first = true },
    json = { "jq" },
    yaml = { "yamlfmt" },
    sql = { "sleek", "sql-formatter", stop_after_first = true },
  },
})

local lint = require("lint")
lint.linters_by_ft = {
  javascript = { "eslint_d" },
  typescript = { "eslint_d" },
  typescriptreact = { "eslint_d" },
  javascriptreact = { "eslint_d" },
  svelte = { "eslint_d" },
  vue = { "eslint_d" },
  c = { "cpplint" },
  go = { "golangcilint" },
}

lint.linters.cpplint.args = {
  "--filter",
  "-whitespace",
  "-legal/copyright",
}

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
  group = vim.api.nvim_create_augroup("LintGroup", { clear = true }),
  callback = function()
    lint.try_lint(nil, { ignore_errors = true })
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  desc = "Conform format",
  group = vim.api.nvim_create_augroup("Autoformat", { clear = true }),
  callback = function(event)
    require("conform").format({
      bufnr = event.buf,
      lsp_fallback = true,
      quiet = true,
    })
  end,
})

vim.keymap.set({ "n", "v" }, "<leader>lp", function()
  require("conform").format({
    lsp_fallback = true,
    async = false,
    timeout_ms = 500,
  })
end, { desc = "Format Code" })
