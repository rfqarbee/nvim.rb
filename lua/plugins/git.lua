return {
  {
    "tpope/vim-fugitive",
    config = function()
      local map = require("custom.utils").map
      map("n", "gs", "<cmd>G<cr>", { silent = true, desc = "Git Fugitive" })
      map("n", "gm", "<cmd>Gvdiffsplit!<cr>", { desc = "Git merge 3 way" })
      map("n", "<leader>gm", "<cmd>G mergetool<cr>", { desc = "Git mergetool" })
      map("n", "dv", "<cmd>Gvdiffsplit<cr>", { desc = "Git diff %" })
      map("n", "<leader>dv", "<cmd>G difftool<cr>", { desc = "Diff tool" })
      map("n", "gb", "<cmd>G blame<cr>", { desc = "Git blame" })
      map("n", "g,", "<cmd>diffget //2<cr>", { desc = "changes from left" })
      map("n", "g.", "<cmd>diffget //3<cr>", { desc = "change from rigth" })
      map("n", "gl", "<cmd>G log -n 30 --oneline --graph<cr>")
    end,
  },
}
