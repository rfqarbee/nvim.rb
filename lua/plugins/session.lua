return {
  {
    "rmagatti/auto-session",
    keys = {
      { "<leader>wr", "<cmd>AutoSession search<CR>", desc = "Session search" },
      { "<leader>wd", "<cmd>AutoSession deletePicker<CR>", desc = "Session search" },
      { "<leader>ws", "<cmd>AutoSession save<CR>", desc = "Save session" },
    },
    lazy = false,
    opts = {
      suppressed_dirs = { "~/", "~/Downloads", "/" },
      git_use_branch_name = true,
      purge_after_minutes = 10080,
      session_lens = {
        picker = "fzf",
        mappings = {
          delete_session = { "i", "<C-x>" },
          alternate_session = { "i", "<C-s>" },
          copy_session = { "i", "<C-y>" },
        },
      },
    },
  },
  {
    "cbochs/grapple.nvim",
    opts = {
      scope = "git_branch",
    },
    event = { "BufReadPost", "BufNewFile" },
    cmd = "Grapple",
    keys = {
      { "<leader>a", "<cmd>Grapple toggle<cr>", desc = "Grapple toggle tag" },
      { "\\", "<cmd>Grapple toggle_tags<cr>", desc = "Grapple open tags window" },
      { "]g", "<cmd>Grapple cycle_tags next<cr>", desc = "Grapple cycle next tag" },
      { "[g", "<cmd>Grapple cycle_tags prev<cr>", desc = "Grapple cycle previous tag" },
      { "<leader>1", "<cmd>Grapple select index=1<cr>", desc = "tag 1" },
      { "<leader>2", "<cmd>Grapple select index=2<cr>", desc = "tag 2" },
      { "<leader>3", "<cmd>Grapple select index=3<cr>", desc = "tag 3" },
      { "<leader>4", "<cmd>Grapple select index=4<cr>", desc = "tag 4" },
      { "<leader>5", "<cmd>Grapple select index=5<cr>", desc = "tag 5" },
    },
  },
}
