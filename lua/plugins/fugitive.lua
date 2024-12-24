return {
  "tpope/vim-fugitive",
  enabled = true,
  config = function()
    local map = require("custom.utils").map
    map("n", "gs", "<cmd>G<cr>", { silent = true, desc = "Git Fugitive" })
    map("n", "gS", "<cmd>G status<cr>", { silent = true, desc = "Git status cli" })
    map("n", "<leader>gm", "<cmd>Gvdiffsplit!<cr>", { desc = "Git merge 3 way" })
    map("n", "<leader>hd", "<cmd>Gvdiffsplit<cr>", { desc = "Diff this" })
    map("n", "<leader>gl", "<cmd>G log --oneline -n 25 %<cr>", { desc = "Git Log current file" })
    map("n", "<leader>gL", "<cmd>G log --oneline -n 25<cr>", { desc = "Git Log branch" })

    map("n", "gh", "<cmd>diffget //2<cr>", { desc = "changes from left" })
    map("n", "gl", "<cmd>diffget //3<cr>", { desc = "change from rigth" })
  end,
}
