return {
  "stevearc/conform.nvim",
  event = "VeryLazy",
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        lua = { "stylua" },
        c = { "clang_format" },
        cpp = { "clang_format" },
        go = { "goimports", "gofumpt" },
        typescript = { "prettierd", "prettier" },
        javascript = { "prettierd", "prettier" },
        typescriptreact = { "prettierd", "prettier" },
        javascriptreact = { "prettierd", "prettier" },
        svelte = { "prettierd", "prettier" },
        json = { "prettierd", "prettier" },
        yaml = { "prettierd", "prettier" },
        markdown = { "prettierd", "prettier" },
        graphql = { "prettierd", "prettier" },
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
