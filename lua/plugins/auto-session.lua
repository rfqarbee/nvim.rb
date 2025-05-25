return {
  'rmagatti/auto-session',
  lazy = false,
  keys = {
    { '<leader>wr', '<cmd>SessionSearch<CR>',      desc = 'Session search' },
    { '<leader>ws', '<cmd>SessionSave<CR>',        desc = 'Save session' },
    { '<leader>wd', '<cmd>Autosession delete<CR>', desc = 'Delete' },
  },
  opts = {
    suppressed_dirs = { '~/', '~/repos', '~/Downloads', '/' },
    git_use_branch_name = true,
  }
}
