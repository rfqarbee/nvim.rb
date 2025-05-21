local map = vim.keymap.set

map({ "n", "v" }, "Q", "<nop>")
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

map("n", "<leader>ll", function()
  local ll_win = vim.fn.getloclist(0, { size = 0, winid = 0 })
  if ll_win.size == 0 then
    vim.notify("Loclist is empty", vim.log.levels.WARN)
  else
    if ll_win.winid ~= 0 then
      vim.cmd("lclose")
    else
      vim.cmd("lopen")
    end
  end
end, { desc = "lopen" })

map("n", "<leader>ql", function()
  local qf_win = vim.fn.getqflist({ size = 0, winid = 0 })
  if qf_win.size == 0 then
    vim.notify("Quickfix is empty", vim.log.levels.WARN)
  else
    if qf_win.winid ~= 0 then
      vim.cmd("cclose")
    else
      vim.cmd("bot copen")
    end
  end
end, { desc = "Copen" })

map("n", "<leader>wq", "<cmd>qa<CR>", { desc = "Quit" })
map("n", "<M-q>", "<cmd>bdelete<CR>", { desc = "Delete buffer" })
map("n", "<C-q>", "<cmd>bun<CR>", { desc = "Unload Buffer" })
map({ "i", "s" }, "<c-c>", "<Esc>", { desc = "<Esc> alias" })

map("n", "<m-n>", "<cmd>cnext<cr>zz", { desc = "Next qf" })
map("n", "<m-p>", "<cmd>cprev<cr>zz", { desc = "Prev qf" })

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
map("x", "<leader>p", '"+p', { desc = "Paste and copy into Clipboard" })

map("n", "<leader>rp", ":%s/", { desc = "Current file search and replace" })
map("n", "<leader>rP", ":%s/<c-r><c-w>/", { desc = "Current file search and replace <cword>" })
map("v", "<leader>rp", ":'<,'>s/", { desc = "Current file search and replace (V)" })
map("v", "<leader>rP", ":'<,'>s/<c-r><c-w>", { desc = "Current file search and replace <cword> (v)" })
