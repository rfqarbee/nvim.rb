return {
  "tpope/vim-fugitive",
  enabled = true,
  config = function()
    local map = require("custom.utils").map
    map("n", "gs", "<cmd>G<cr>", { silent = true, desc = "Git status" })
    map("n", "gS", "<cmd>G status<cr>", { silent = true, desc = "Git status" })
    map("n", "<leader>gv", "<cmd>Gvdiffsplit!<cr>", { desc = "Git vdiff" })
    map("n", "<leader>gl", "<cmd>G log --oneline -n 30 %<cr>", { desc = "Git Log current file" })
    map("n", "<leader>gL", "<cmd>G log --oneline -n 30<cr>", { desc = "Git Log branch" })
    map("n", "<leader>gc", "<cmd>G commit<cr>", { desc = "Git commit " })

    map("n", "gh", "<cmd>diffget //2<cr>", { desc = "changes from left" })
    map("n", "gl", "<cmd>diffget //3<cr>", { desc = "change from rigth" })
  end,
}
