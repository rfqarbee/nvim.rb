return {
  "lewis6991/gitsigns.nvim",
  config = function()
    require("gitsigns").setup({
      signs = {
        add = { text = "+" },
        change = { text = "~" },
      },
      signs_staged = {
        add = { text = "┃" },
        change = { text = "┃" },
      },
      numhl = true,
      attach_to_untracked = true,
      current_line_blame = true,
      current_line_blame_opts = {
        delay = 150,
      },
    })

    require("gitsigns").setup({
      on_attach = function(bufnr)
        local gitsigns = require("gitsigns")
        local map = require("custom.utils").map

        map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "Stage Hunk", buffer = bufnr })
        map("v", "<leader>hs", function()
          gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, { desc = "Stage Hunk", buffer = bufnr })
        map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "Stage Hunk Buffer", buffer = bufnr })
        map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "Reset Hunk", buffer = bufnr })
        map("v", "<leader>hr", function()
          gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, { desc = "Reset Hunk", buffer = bufnr })
        map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "Reset Hunk Buffer", buffer = bufnr })
        map("n", "<leader>hu", gitsigns.undo_stage_hunk, { desc = "Undo Stage Hunk", buffer = bufnr })
        map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "Preview Hunk", buffer = bufnr })
        map("n", "<leader>hb", function()
          gitsigns.blame_line({ full = true })
        end, { desc = "Blame Hunk", buffer = bufnr })
        map("n", "<leader>td", gitsigns.toggle_deleted, { desc = "Toggle Deleted Hunk", buffer = bufnr })

        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Gitsigns select Hunk", buffer = bufnr })
      end,
    })
  end,
}
