return {
  "cbochs/grapple.nvim",
  opts = {
    scope = "git_branch", -- also try out "git_branch"
    style = "basename",
  },
  event = { "BufReadPost", "BufNewFile" },
  cmd = "Grapple",
  keys = {
    { "<leader>a", "<cmd>Grapple toggle<cr>",          desc = "Grapple toggle tag" },
    { "\\",        "<cmd>Grapple toggle_tags<cr>",     desc = "Grapple open tags window" },
    { "<M-l>",     "<cmd>Grapple cycle_tags next<cr>", desc = "Grapple cycle next tag" },
    { "<M-h>",     "<cmd>Grapple cycle_tags prev<cr>", desc = "Grapple cycle previous tag" },
    { "<leader>1", "<cmd>Grapple select index=1<cr>",  desc = "Index 1" },
    { "<leader>2", "<cmd>Grapple select index=2<cr>",  desc = "Index 2" },
    { "<leader>3", "<cmd>Grapple select index=3<cr>",  desc = "Index 3" },
    { "<leader>4", "<cmd>Grapple select index=4<cr>",  desc = "Index 4" },
  },
}
