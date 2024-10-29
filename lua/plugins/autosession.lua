return {
  "rmagatti/auto-session",
  lazy = false,
  opts = function(_, opts)
    local map = require("custom.utils").map

    vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
    opts.enabled = true
    opts.suppressed_dirs = { "~/", "~/repos/", "~/Downloads", "/" }
    opts.use_git_branch = true
    opts.log_level = "error"
    opts.session_lens = {
      load_on_setup = false,
    }

    -- map("n","<leader>wl","<cmd>Session")
    map("n", "<leader>ws", "<cmd>SessionSave<cr>")
    map("n", "<leader>wr", "<cmd>SessionRestore<cr>")
  end,
}
