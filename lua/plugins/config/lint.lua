return {
  "mfussenegger/nvim-lint",
  cond = function()
    local work = os.getenv("WORK")
    local exp = work .. "/contract-root"
    local cur = vim.fn.getcwd()
    if exp == cur then
      return false
    else
      return true
    end
  end,
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")
    local map = require("custom.utils").map
    lint.linters_by_ft = {
      javascript = { "eslint_d", "eslint" },
      typescript = { "eslint_d", "eslint" },
      typescriptreact = { "eslint_d", "eslint" },
      javascriptreact = { "eslint_d", "eslint" },
      svelte = { "eslint_d", "eslint" },
      c = { "cpplint" },
    }

    lint.linters.cpplint.args = {
      "--filter",
      "-whitespace",
      "-legal/copyright",
    }

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
      group = vim.api.nvim_create_augroup("LintGroup", { clear = true }),
      callback = function()
        lint.try_lint()
      end,
    })

    map("n", "<leader>ll", function()
      lint.try_lint()
    end, { desc = "Linting" })
  end,
}
