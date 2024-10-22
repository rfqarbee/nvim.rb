local lsp_utils = require("lspconfig.util").root_pattern(".git")
local M = {}

local params = {
  command = "_typescript.organizeImports",
  arguments = { vim.api.nvim_buf_get_name(0) }, -- current buffer
}

M.tsserver = {
  root_dir = function(fname)
    return lsp_utils(fname)
  end,
  commands = {
    OrganizeImports = {
      vim.lsp.buf.execute_command(params),
      descrption = "Organize Imports",
    },
  },
  settings = {
    preferences = {
      includeInlayParameterNameHints = "all",
      includeInlayParameterNameHintsWhenArgumentMatchesName = false,
      includeInlayVariableTypeHints = false,
      includeInlayFunctionParameterTypeHints = false,
      includeInlayVariableTypeHintsWhenTypeMatchesName = false,
      includeInlayPropertyDeclarationTypeHints = false,
      includeInlayFunctionLikeReturnTypeHints = true,
      includeInlayEnumMemberValueHints = true,
    },
    public_diagnostic_on = "insert_leave",
  },
}

return M
