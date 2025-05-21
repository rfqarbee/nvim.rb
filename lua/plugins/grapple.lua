return {
  "cbochs/grapple.nvim",
  opts = {
    scope = "git_branch",
    style = "basename",
  },
  event = { "BufReadPost", "BufNewFile" },
  cmd = "Grapple",
  keys = {
    { "<leader>a", "<cmd>Grapple toggle<cr>",          desc = "Tag grapple" },
    { "\\",        "<cmd>Grapple toggle_tags<cr>",     desc = "grapple window" },
    { "<leader>k", "<cmd>Grapple cycle_tags next<cr>", desc = "prev tag" },
    { "<leader>j", "<cmd>Grapple cycle_tags prev<cr>", desc = "next tag" },
    { "<leader>1", "<cmd>Grapple select index=1<cr>",  desc = "Index 1" },
    { "<leader>2", "<cmd>Grapple select index=2<cr>",  desc = "Index 2" },
    { "<leader>3", "<cmd>Grapple select index=3<cr>",  desc = "Index 3" },
    { "<leader>4", "<cmd>Grapple select index=4<cr>",  desc = "Index 4" },
  },
}
