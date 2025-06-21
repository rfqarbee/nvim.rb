return {
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = { "nvim-treesitter/nvim-treesitter", },
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
          enable = false,
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
            },
            selection_modes = {
              ['@parameter.outer'] = 'v', -- charwise
              ['@function.outer'] = 'V',  -- linewise
              ['@class.outer'] = '<c-v>', -- blockwise
            },
            include_surrounding_whitespace = true,
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              ["]f"] = "@function.outer",
              ["]]"] = "@class.outer",
            },
            goto_next_end = {
              ["]F"] = "@function.outer",
              ["]["] = "@class.outer",
            },
            goto_previous_start = {
              ["[f"] = "@function.outer",
              ["[["] = "@class.outer",
            },
            goto_previous_end = {
              ["[F"] = "@function.outer",
              ["[]"] = "@class.outer",
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ["<leader>."] = "@parameter.inner",
            },
            swap_previous = {
              ["<leader>,"] = "@parameter.inner",
            },
          },
        },
      })
    end,
  },
  {
    'aaronik/treewalker.nvim',
    enabled = false,
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
