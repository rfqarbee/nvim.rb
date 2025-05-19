return {
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require('nvim-ts-autotag').setup({
        opts = {
          enable_close = true,          -- Auto close tags
          enable_rename = true,         -- Auto rename pairs of tags
          enable_close_on_slash = false -- Auto close on trailing </
        },
        per_filetype = {
          ["html"] = {
            enable_close = false
          }
        }
      })
    end
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

        "c",
        "c_sharp",
        "go",
        "lua",
        "sql",

        "dockerfile",
        "gitignore",
        "http",
        "json",
        "make",
        "toml",
        "yaml",

        -- qol
        "comment",
        "bash",
        "luadoc",
        "vimdoc",
        "markdown",
        "markdown_inline",
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

      local nvim_treesitter = require("nvim-treesitter")
      local function ctx()
        local treectx = nvim_treesitter.statusline({
          indicator_size = 150,
          type_patterns = { "class", "function", "method" },
        })

        if treectx == "" then
          return "---No Context---"
        else
          return treectx
        end
      end

      vim.keymap.set("n", "<leader>cb", function()
        vim.print(ctx())
      end, { desc = "Show current code context" })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    config = function()
      require("nvim-treesitter.configs").setup({
        textobjects = {
          swap = {
            enable = true,
            swap_next = {
              ["<leader>."] = "@parameter.inner",
            },
            swap_previous = {
              ["<leader>,"] = "@parameter.inner",
            },
          },
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["if"] = "@function.inner",
              ["af"] = "@function.outer",
              ["ia"] = "@parameter.inner",
              ["aa"] = "@parameter.outer",
              ["ic"] = "@class.inner",
              ["ac"] = "@class.outer",
              ["ii"] = "@conditional.inner",
              ["ai"] = "@conditional.outer",
              ["il"] = "@loop.inner",
              ["al"] = "@loop.outer",
              ["at"] = "@comment.outer",
              ["as"] = { query = "@local.scope", query_group = "locals", desc = "Select language scope" },
            },
            selection_modes = {
              ["@parameter.outer"] = "v",
              ["@function.outer"] = "V",
              ["@class.outer"] = "V",
              ["@conditional.outer"] = "V",
            },
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              ["]f"] = "@function.outer",
              ["]]"] = { query = "@class.outer", desc = "Next class start" },
              ["]l"] = "@loop.*",
              ["]s"] = { query = "@local.scope", query_group = "locals", desc = "Next scope" },
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
            -- Below will go to either the start or the end, whichever is closer.
            -- Use if you want more granular movements
            -- Make it even more gradual by adding multiple queries and regex.
            goto_next = {
              ["]c"] = "@conditional.outer",
            },
            goto_previous = {
              ["[c"] = "@conditional.outer",
            },
          },
        },
      })

      local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")

      vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move, { desc = "Repeat Last Move" })
      vim.keymap.set(
        { "n", "x", "o" },
        ",",
        ts_repeat_move.repeat_last_move_opposite,
        { desc = "Repeat Last Move opposite" }
      )
      vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true, desc = "Repeat move f" })
      vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true, desc = "Repeat move F" })
      vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true, desc = "Repeat move t" })
      vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true, desc = "Repeat move T" })
    end,
  },
}
