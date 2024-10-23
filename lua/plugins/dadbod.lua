return {
  "kristijanhusak/vim-dadbod-ui",
  enabled = true,
  lazy = true,
  dependencies = {
    { "tpope/vim-dadbod", lazy = true },
    { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true }, -- Optional
  },
  cmd = {
    "DBUI",
    "DBUIToggle",
    "DBUIAddConnection",
    "DBUIFindBuffer",
  },
  init = function()
    -- Your DBUI configuration
    vim.g.db_ui_use_nerd_fonts = 1
    vim.g.db_ui_win_position = "left"
    local map = require("utils.utils")

    map("n", "<leader>do", "<cmd>DBUIToggle<cr>")
  end,
}
