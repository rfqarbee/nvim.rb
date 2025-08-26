return {
  {

    "tpope/vim-fugitive",
    config = function()
      local map = require("custom.utils").map
      map("n", "gs", "<cmd>G<cr>", { silent = true, desc = "Git Fugitive" })
      map("n", "gm", "<cmd>Gvdiffsplit!<cr>", { desc = "Git merge 3 way" })
      map("n", "dv", "<cmd>Gvdiffsplit<cr>", { desc = "Git diff %" })
      map("n", "gb", "<cmd>G blame<cr>", { desc = "Git blame" })
      map("n", "g,", "<cmd>diffget //2<cr>", { desc = "changes from left" })
      map("n", "g.", "<cmd>diffget //3<cr>", { desc = "change from rigth" })
      map("n", "gl", "<cmd>G log -n 30 --oneline --graph<cr>")
    end,
  },
  -- {
  --   "lewis6991/gitsigns.nvim",
  --   config = function()
  --     local gitsigns = require("gitsigns")
  --     gitsigns.setup({
  --       attach_to_untracked = true,
  --       current_line_blame = true,
  --       current_line_blame_opts = {
  --         delay = 300,
  --       },
  --     })
  --
  --     -- tst
  --     gitsigns.setup({
  --       on_attach = function(bufnr)
  --         local map = require("custom.utils").map
  --         map("n", "<m-n>", function() gitsigns.nav_hunk('next') end)
  --         map("n", "<m-p>", function() gitsigns.nav_hunk('prev') end)
  --         map("n", "<leader>hs", function() gitsigns.stage_hunk() end)
  --         map("n", "<leader>hr", function() gitsigns.reset_hunk() end)
  --         map("n", "<leader>hR", function() gitsigns.reset_buffer() end)
  --         map("n", "<leader>hS", function() gitsigns.stage_buffer() end)
  --         map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "Preview Hunk", buffer = bufnr })
  --       end,
  --     })
  --   end,
  -- },
}
