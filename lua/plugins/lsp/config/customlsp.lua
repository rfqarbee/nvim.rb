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

local svelte = {
  pattern = { "*.js", "*.ts" },
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

M.servers = {
  clangd = clangd,
  csharp_ls = csharp,
  dartls = dartls,
  gopls = gopls,
  lua_ls = lua_ls,
  prismals = true,
  svelte = svelte,
}

return M
