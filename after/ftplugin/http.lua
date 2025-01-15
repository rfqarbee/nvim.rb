-- kulala
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

-- rest nvim
vim.keymap.set("n", "<leader>xr", "<cmd>Rest run<cr>", { desc = "Run Request", buffer = 0 })
vim.keymap.set("n", "<leader>xx", "<cmd>echo &filetype<cr>", { buffer = 0, desc = "Run Request" })
vim.keymap.set("n", "<leader>xl", "<cmd>tab Rest logs<cr>", { buffer = 0, desc = "Rest Logs" })
vim.keymap.set("n", "<leader>xc", "<cmd>tab Rest cookies<cr>", { buffer = 0, desc = "Rest Cookies" })
vim.keymap.set("n", "<leader>xy", "<cmd>Rest curl yank<cr>", { buffer = 0, desc = "To curl" })
vim.keymap.set("n", "<leader>xY", "<cmd>Rest curl comment<cr>", { buffer = 0, desc = "comment curl" })
vim.keymap.set("n", "<leader>xs", "<cmd>Rest env show<cr>", { buffer = 0, desc = "env show" })
vim.keymap.set("n", "<leader>xS", "<cmd>Rest env select<cr>", { buffer = 0, desc = "env select" })
