local map = vim.keymap.set

map({ "n", "v" }, "Q", "<nop>")
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

map("n", "<M-q>", "<cmd>bd<CR>", { desc = "Quit" })
map("n", "<leader>wq", "<cmd>qa<CR>", { desc = "Quit" })
map("n", "<leader>wn", "<cmd>tabnew<cr>", { desc = "New Tab" })
map("n", "<leader>wm", "<cmd>tabnew %<cr>", { desc = "Move to new tab" })

-- my fingers are sore!
map("n", "<leader>wh", "<C-w>h")
map("n", "<leader>wl", "<C-w>l")
map("n", "<leader>wj", "<C-w>j")
map("n", "<leader>wk", "<C-w>k")
map("n", "<leader>wv", "<C-w>v")
map("n", "<leader>ws", "<C-w>s")
map("n", "<leader>ww", "<C-w>w")
map("n", "<leader>wc", "<C-w>c")

-- i dont care gT, never have more than 3 anyways
map("n", "<leader><tab>", "gt")

map({ "n", "v" }, "L", "$", { desc = "End of line" })
map({ "n", "v" }, "H", "^", { desc = "Start of line" })

map("n", "<s-x>", "<C-w>c")
map("n", "<s-q>", ":bd<cr>")
map("n", "<M-,>", "<C-w>5>", { desc = "Shift left window size" })
map("n", "<M-.>", "<C-w>5<", { desc = "Shift right window size" })
-- map("n", "<M-->", "<C-w>2-", { desc = "Decrease Window Size" })
-- map("n", "<M-=>", "<C-w>2+", { desc = "Increase Window Size" })

map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move Selected Line Above" })
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move Selected Line Below" })

map("n", "J", "mzJ`z", { desc = "Center cursor" })

map("n", "<C-d>", "<C-d>zz", { desc = "Center Cursor Half-page" })
map("n", "<C-u>", "<C-u>zz", { desc = "Center Cursor Half-page" })
map("n", "<C-f>", "<C-d>zz", { desc = "Center Cursor Full-page" })
map("n", "<C-b>", "<C-u>zz", { desc = "Center Cursor Full-page" })

map("n", "n", "nzzzv", { desc = "Center cursor next search" })
map("n", "N", "Nzzzv", { desc = "Center cursor next search" })

map("n", "<C-f>", "<cmd>silent !tmux neww tmux_session.sh<cr>")

map("x", "<c-p>", '"_dP', { desc = "Paste w/o Clipboard" })
map("n", "<leader>rp", ":%s/<C-r><C-w>/", { desc = "Current file search and replace" })
map("x", "z/", "<C-\\><C-n>`</\\%V", { desc = "Search forward within visual selection" })
map("x", "z?", "<C-\\><C-n>`>?\\%V", { desc = "Search backward within visual selection" })
