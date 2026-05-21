-- vim.pack.add({
--   "https://github.com/stevearc/oil.nvim",
-- })
--
-- local oil = require("oil")
-- oil.setup({
--   columns = {
--     "mtime",
--     "permissions",
--   },
--   view_options = {
--     show_hidden = true,
--     is_hidden_file = function(name)
--       return vim.startswith(name, ".")
--     end,
--   },
--   natural_order = false,
--   use_default_keymaps = false,
--   delete_to_trash = true, -- in $XDG_DATA_HOME/Trash
--   skip_confirm_for_simple_edits = true,
--   keymaps = {
--     ["<CR>"] = "actions.select",
--     ["<C-v>"] = "actions.select_vsplit",
--     ["<C-s>"] = "actions.select_split",
--     ["<C-t>"] = "actions.select_tab",
--     ["<M-p>"] = "actions.preview",
--     ["q"] = "actions.close",
--     ["<space>r"] = "actions.refresh", -- refresh list
--     ["-"] = "actions.parent",
--     ["_"] = "actions.open_cwd",
--     ["`"] = "actions.tcd", -- change current tab directory
--     ["<leader>gs"] = "actions.change_sort",
--     ["g\\"] = "actions.toggle_trash",
--   },
-- })
--
-- vim.keymap.set("n", "<leader>o-", function()
--   oil.open()
-- end, { desc = "directory" })

-- yazi
vim.pack.add({ "https://github.com/mikavilpas/yazi.nvim" })

local yazi = require("yazi")
yazi.setup({
  integrations = {
    grep_in_selected_files = "fzf-lua",
    grep_in_directory = "fzf-lua",
  },
})
vim.keymap.set("n", "-", function()
  yazi.yazi()
end)
