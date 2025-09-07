return {
  "stevearc/conform.nvim",
  event = "VeryLazy",
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        lua = { "stylua" },
        c = { "clang_format" },
        go = { "goimports", "gofumpt", stop_after_first = true },
        svelte = { "prettierd", "prettier", stop_after_first = true },
        vue = { "prettierd", "prettier", stop_after_first = true },
        typescript = { "prettierd", "prettier", stop_after_first = true },
        typescriptreact = { "prettierd", "prettier", stop_after_first = true },
        graphql = { "prettierd", "prettier", stop_after_first = true },
        json = { "jq" },
        yaml = { "yamlfmt" },
        http = { "kulala-fmt" },
        sql = { "sleek", "sql-formatter", stop_after_first = true },
      },
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
  end,
}
