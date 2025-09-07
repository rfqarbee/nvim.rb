local map = vim.keymap.set

map({ "n", "v" }, "Q", "<nop>")
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

map("n", "<leader>wq", "<cmd>qa<CR>", { desc = "Quit" })
map("n", "<M-q>", "<cmd>bun<CR>", { desc = "Unload Buffer" })

map("n", "<leader>w.", "<cmd>+tabmove<cr>", { desc = "Tab to right" })
map("n", "<leader>w,", "<cmd>-tabmove<cr>", { desc = "Tab to left" })
map("n", "<leader>wn", "<cmd>tabnew<cr>", { desc = "New Tab" })
map("n", "<leader>wt", "<cmd>tabnew %<cr>", { desc = "Move to new tab" })
map("n", "<leader>wo", "<cmd>tabonly<cr>", { desc = "Discard all other tabs" })

map({ "n", "v" }, "L", "$", { desc = "End of line" })
map({ "n", "v" }, "H", "^", { desc = "Start of line" })

map("n", "<M-,>", "<C-w>5>", { desc = "Shift left window size" })
map("n", "<M-.>", "<C-w>5<", { desc = "Shift right window size" })
map("n", "<M-->", "<C-w>2-", { desc = "Decrease Window Size" })
map("n", "<M-=>", "<C-w>2+", { desc = "Increase Window Size" })

map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move Selected Line Above" })
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move Selected Line Below" })

map("n", "J", "mzJ`z", { desc = "Center cursor" })

map("n", "<C-d>", "<C-d>zz", { desc = "Center Cursor Half-page" })
map("n", "<C-u>", "<C-u>zz", { desc = "Center Cursor Half-page" })
map("n", "<C-f>", "<C-d>zz", { desc = "Center Cursor Full-page" })
map("n", "<C-b>", "<C-u>zz", { desc = "Center Cursor Full-page" })

map("n", "n", "nzzzv", { desc = "Center cursor next search" })
map("n", "N", "Nzzzv", { desc = "Center cursor next search" })

map("x", "p", '"_dP', { desc = "Paste w/o Clipboard" })
map("n", "<leader>rp", ":%s/", { desc = "Current file search and replace" })
map("v", "<leader>rp", ":'<,'>s/", { desc = "Current file search and replace (V)" })
map("x", "z/", "<C-\\><C-n>`</\\%V", { desc = "Search forward within visual selection" })
map("x", "z?", "<C-\\><C-n>`>?\\%V", { desc = "Search backward within visual selection" })
