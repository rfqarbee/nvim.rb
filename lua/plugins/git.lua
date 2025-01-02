return {
  {
    "tpope/vim-fugitive",
    enabled = true,
    config = function()
      local map = require("custom.utils").map
      map("n", "gs", "<cmd>tab G<cr>", { silent = true, desc = "Git Fugitive" })
      map("n", "gS", "<cmd>G status<cr>", { silent = true, desc = "Git status cli" })
      map("n", "<leader>gm", "<cmd>Gvdiffsplit!<cr>", { desc = "Git merge 3 way" })
      -- map("n", "<leader>gd", "<cmd>Gvdiffsplit<cr>", { desc = "Diff this" })

      map("n", "gh", "<cmd>diffget //2<cr>", { desc = "changes from left" })
      map("n", "gl", "<cmd>diffget //3<cr>", { desc = "change from rigth" })
    end,
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "sindrets/diffview.nvim",
    },
    config = function()
      local neogit = require("neogit")
      neogit.setup({
        disable_insert_on_commit = true,
        disable_line_numbers = false,
        disable_relative_line_numbers = false,
        integrations = {
          fzf_lua = true,
        },
      })
      require("custom.utils").map("n", "<leader>gs", "<cmd>Neogit cwd=%:p:h<cr>")
      require("custom.utils").map("n", "<leader>gd", "<cmd>DiffviewOpen<cr>")
    end,
  },
}
