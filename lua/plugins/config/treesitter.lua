return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  config = function()
    local ensure_installed = {
      "json",
      "typescript",
      "javascript",
      "html",
      "css",
      "tsx",
      "svelte",
      "prisma",
      "bash",
      "c",
      "make",
      "dart",
      "go",
      "sql",
      "http",
      "gitignore",
      "dockerfile",
      "graphql",
      "toml",
      "yaml",
      "lua",
      "luadoc",
      "vimdoc",
      "rust",
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
