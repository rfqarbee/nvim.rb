return {
  "NeogitOrg/neogit",
  enabled = false,
  dependencies = {
    "nvim-lua/plenary.nvim", -- required
    {
      "sindrets/diffview.nvim",
      opts = function(_, opts)
        local actions = require("diffview.actions")
        opts.keymaps = {
          view = {
            ["<c-n>"] = actions.select_next_entry,
            ["<c-p>"] = actions.select_prev_entry,
          },
          file_history_panel = {
            ["<c-n>"] = actions.select_next_entry,
            ["<c-p>"] = actions.select_prev_entry,
          },
          file_panel = {
            ["<c-n>"] = actions.select_next_entry,
            ["<c-p>"] = actions.select_prev_entry,
          },
        }
      end,
    },
  },
  opts = function(_, opts)
    opts.disable_line_numbers = false
    opts.disable_insert_on_commit = true
    opts.sections = {
      recent = {
        folded = false,
      },
    }
    opts.status = {
      recent_commit_count = 15,
    }
    opts.mappings = {
      status = {
        ["1"] = false,
        ["2"] = false,
        ["3"] = false,
        ["4"] = false,
      },
    }
    opts.signs = {
      hunk = { "", "" },
      section = { "", "󰅀" },
      item = { "", "" },
    }
    -- vim.keymap.set("n", "<leader>ns", "<cmd>Neogit<cr>", { desc = "Git status" })
    -- vim.keymap.set("n", "gs", "<cmd>Neogit<cr>", { desc = "Git status" })
    -- vim.keymap.set("n", "<leader>gs", "<cmd>Neogit cwd=%:p:h<cr>", { desc = "Git current buffer path status" })
    -- vim.keymap.set("n", "<leader>gd", "<cmd>Neogit diff<cr>", { desc = "Git diff" })
    -- vim.keymap.set("n", "<leader>nc", "<cmd>Neogit cwd=%:p:h commit<cr>", { desc = "Git status" })
  end,
}
