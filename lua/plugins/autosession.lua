return {
  "rmagatti/auto-session",
  enabled = true,
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

    map("n", "<leader>ws", "<cmd>SessionSave<cr>")
    map("n", "<leader>wr", "<cmd>SessionRestore<cr>")
    map("n", "<leader>wl", "<cmd>Autosession search<cr>")
    map("n", "<leader>wd", "<cmd>Autosession delete<cr>")
  end,
}
