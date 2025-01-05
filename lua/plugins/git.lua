return {
  {
    "tpope/vim-fugitive",
    config = function()
      local map = require("custom.utils").map
      map("n", "gs", "<cmd>tab G<cr>", { silent = true, desc = "Git Fugitive" })
      map("n", "gS", "<cmd>G status<cr>", { silent = true, desc = "Git status cli" })
      map("n", "<leader>gm", "<cmd>Gvdiffsplit!<cr>", { desc = "Git merge 3 way" })
      map("n", "<leader>gd", "<cmd>Gvdiffsplit<cr>", { desc = "Git diff %" })
      map("n", "gh", "<cmd>diffget //2<cr>", { desc = "changes from left" })
      map("n", "gl", "<cmd>diffget //3<cr>", { desc = "change from rigth" })
      map("n", "<leader>gl", "<cmd>G log -n 30 --oneline<cr>")
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      local gitsigns = require("gitsigns")
      gitsigns.setup({
        attach_to_untracked = true,
        current_line_blame = true,
        current_line_blame_opts = {
          delay = 150,
        },
      })

      gitsigns.setup({
        on_attach = function(bufnr)
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
  },
}
