-- temporarily using this
return {
  "pmizio/typescript-tools.nvim",
  enabled = true,
  ft = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
  dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  config = function()
    require("typescript-tools").setup({
      single_file_support = false,
      root_dir = function()
        local root = vim.fs.root(0, ".git")
        if root == nil then
          return vim.fs.root(0, "index.js")
        else
          return root
        end
      end,
      settings = {
        separate_diagnostic_server = true,
        tsserver_file_preferences = {
          includeInlayParameterNameHints = "all",
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayVariableTypeHints = false,
          includeInlayFunctionParameterTypeHints = false,
          includeInlayVariableTypeHintsWhenTypeMatchesName = false,
          includeInlayPropertyDeclarationTypeHints = false,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        },
        publish_diagnostic_on = "insert_leave",
      },
    })

    vim.keymap.set("n", "<leader>li", function()
      vim.notify("Organizing imports")
      vim.cmd("TSToolsOrganizeImports")
    end, { desc = "Remove unused and organize imports" })

    vim.keymap.set("n", "<leader>la", function()
      vim.notify("Adding missing import")
      vim.cmd("TSToolsAddMissingImports")
    end, { desc = "Add missing imports" })
  end,
}
