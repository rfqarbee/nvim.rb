return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  config = function()
    local ensure_installed = {
      "html",
      "css",
      "json",
      "tsx",
      "typescript",
      "javascript",
      "svelte",
      "prisma",
      "graphql",

      "toml",
      "yaml",

      "lua",
      "c",
      "make",

      "dart",

      "go",
      "rust",
      "http",
      "sql",
      "dockerfile",
      "gitignore",

      "bash",
      "luadoc",
      "vimdoc",
      "markdown_inline",
      "markdown",
    }

    require("nvim-treesitter.configs").setup({

      ensure_installed = ensure_installed,
      highlight = { enable = true },
      indent = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "gnn", -- set to `false` to disable one of the mappings
          node_incremental = "grn",
          scope_incremental = "grc",
          node_decremental = "grm",
        },
      },
    })
  end,
}
