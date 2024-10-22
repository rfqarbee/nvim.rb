local M = {}
local lspconfig = require("lspconfig")

local lua_ls = {
  settings = {
    Lua = {
      hint = { enable = true },
      runtime = {
        version = "LuaJIT",
        path = vim.split(package.path, ";"),
      },
      -- diagnostics = { globals = { "vim" } },
      workspace = {
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
        },
      },
    },
  },
}

local cssls = true

local svelte = {
  pattern = { "*.js", "*.ts" },
}

local function organize_imports()
  local params = {
    command = "_typescript.organizeImports",
    arguments = { vim.api.nvim_buf_get_name(0) },
    title = "",
  }
  vim.lsp.buf.execute_command(params)
end

local tsserver = {
  root_dir = function(fname)
    return require("lspconfig.util").root_pattern(".git")(fname)
  end,
  commands = {
    OrganizeImports = {
      organize_imports,
      description = "Organize imports",
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

local dartls = {
  cmd = {
    "dart",
    "language-server",
    "--protocol=lsp",
  },
  filetypes = { "dart" },
  init_options = {
    closingLabels = true,
    flutterOutline = true,
    onlyAnalyzeProjectsWithOpenFiles = true,
    outline = true,
    suggestFromUnimportedLibraries = true,
  },
  root_dir = lspconfig.util.root_pattern("pubspec.yaml"),
  settings = {
    dart = {
      analysisExcludeFolders = {
        vim.fn.expand("$XDG_CONFIG_HOME/pub_cache"),
        vim.fn.expand("$XDG_DATA_HOME/mise/installs/flutter/"),
      },
      updateImportsOnRename = true,
      completeFunctionCalls = true,
      showTodos = true,
    },
  },
}

local rust_analyzer = true

local gopls = {
  analyses = {
    unusedparams = true,
  },
  gofumpt = true,
  staticcheck = true,
}

local clangd = {
  init_options = { clangdFileStatus = true },
  filetypes = { "c", "cpp" },
}

local csharp = true

--test
M.servers = {
  -- NOTE: only setup; not really required right now
  csharp_ls = csharp,
  svelte = svelte,
  dartls = dartls,
  rust_analyzer = rust_analyzer,
  prismals = true,
  lua_ls = lua_ls,
  cssls = cssls,
  gopls = gopls,
  clangd = clangd,
  -- ts_ls = tsserver,
}

-- NOTE: unlikely will need this i guess? but its helps; disable for now
-- local servers_to_install = vim.tbl_filter(function(key)
--   local t = servers[key]
--   if key ~= "dartls" then
--     if type(t) == "table" then
--       return not t.manual_install
--     else
--       return t
--     end
--   end
-- end, vim.tbl_keys(servers))
-- vim.list_extend(ensure_installed, servers_to_install)

return M
