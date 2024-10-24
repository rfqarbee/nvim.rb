return {
  {
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
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local map = require("custom.utils").map
      require("treesitter-context").setup({
        enable = false,
        max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
        min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
        line_numbers = true,
        multiline_threshold = 25, -- Maximum number of lines to show for a single context
        trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
        mode = "cursor",
        separator = "-",
        zindex = 20, -- The Z-index of the context window
        on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
      })

      map("n", "<leader>tc", "<cmd>TSContextToggle<cr>", { desc = "Toggle Treesitter Context" })
    end,
  },
}
