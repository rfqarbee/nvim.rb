return {
  "mistweaverco/kulala.nvim",
  ft = "http",
  config = function()
    require("kulala").setup({
      default_env = "development",
      default_view = "headers_body",
      default_winbar_panes = { "headers_body", "body", "headers", "scripts_output", "stats" },
      winbar = true,
    })
    local map = function(key, cmd, desc)
      vim.keymap.set("n", key, ":lua require('kulala')." .. cmd .. "<cr>", { desc = desc, noremap = true, buffer = 0 })
    end

    map("<leader>kr", "run()", "Run request")
    map("<leader>kc", "copy()", "Copy to curl")
    map("<leader>pk", "search()", "Search request")
    map("<leader>ki", "inspect()", "Inspect")
    map("<M-j>", "jump_next()", "Inspect")
    map("<M-k>", "jump_prev()", "Inspect")
    map("<leader>ke", "get_selected_env()", "Show stats")
    map("<leader>ks", "set_selected_env()", "Show stats")
  end,
}
