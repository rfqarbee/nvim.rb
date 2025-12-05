return {
  {
    "rmagatti/auto-session",
    keys = {
      { "<leader>wr", "<cmd>AutoSession search<CR>", desc = "Session search" },
      { "<leader>wd", "<cmd>AutoSession deletePicker<CR>", desc = "Session search" },
      { "<leader>wp", "<cmd>AutoSession save<CR>", desc = "Save session" },
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
}
