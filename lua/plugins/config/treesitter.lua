return {
  {
    "nvim-treesitter/nvim-treesitter-context",
    opts = { max_lines = 2 }
  },
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    config = function()
      local ensure_installed = {
        "tsx",
        "typescript",
        "javascript",
        "graphql",
        "sql",
        "c_sharp",
        "go",
        "lua",
        "dockerfile",
        "json",
        "comment",
      }

      require("nvim-treesitter.configs").setup({
        ensure_installed = ensure_installed,
        highlight = {
          enable = true,
          disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            ---@diagnostic disable-next-line: undefined-field
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,
        },
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
    'aaronik/treewalker.nvim',
    config = function()
      local km = require("custom.utils").map
      require("treewalker").setup({
        highlight = true,
        highlight_duration = 250,
        highlight_group = 'CursorLine',
        jumplist = true,
      })
      km({ 'n', 'v' }, '<M-k>', '<cmd>Treewalker Up<cr>', { silent = true })
      km({ 'n', 'v' }, '<M-j>', '<cmd>Treewalker Down<cr>', { silent = true })
      km({ 'n', 'v' }, '<M-h>', '<cmd>Treewalker Left<cr>', { silent = true })
      km({ 'n', 'v' }, '<M-l>', '<cmd>Treewalker Right<cr>', { silent = true })
      km('n', '<leader>=', '<cmd>Treewalker SwapDown<cr>', { silent = true })
      km('n', '<leader>-', '<cmd>Treewalker SwapUp<cr>', { silent = true })
      km('n', '<leader>,', '<cmd>Treewalker SwapLeft<cr>', { silent = true })
      km('n', '<leader>.', '<cmd>Treewalker SwapRight<cr>', { silent = true })
    end
  },
}
