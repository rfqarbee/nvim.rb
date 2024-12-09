local map = vim.keymap.set

map({ "n", "v" }, "Q", "<nop>")
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear highlight on search when Esc in normal mode" })

map("n", "<leader>ql", function()
  local qf_win = vim.fn.getqflist({ winid = 0 }).winid
  if qf_win ~= 0 then
    vim.cmd("cclose")
  else
    vim.cmd("bot copen")
  end
end, { desc = "Copen" })

map("n", "<C-q>", "<cmd>qa<CR>", { desc = "Quit Neovim" })
map("n", "<M-q>", "<cmd>bd<CR>", { desc = "Delete Buffer" })
map({ "i", "s" }, "jk", "<Esc>", { desc = "Insert to normal mode" })
map({ "i", "s" }, "<c-c>", "<Esc>", { desc = "Insert to normal mode" })

map("n", "<m-j>", "<cmd>cnext<cr>zz", { desc = "Next quickfix item" })
map("n", "<m-k>", "<cmd>cprev<cr>zz", { desc = "Prev quickfix item" })

map("n", "]b", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "[b", "<cmd>bprev<cr>", { desc = "Prev Buffer" })

map("n", "<leader>t.", "<cmd>+tabmove<cr>", { desc = "Move tab to right" })
map("n", "<leader>t,", "<cmd>-tabmove<cr>", { desc = "Move tab to left" })
map("n", "<leader>tn", "<cmd>tabnew<cr>", { desc = "Create new tab" })

map({ "n", "v" }, "L", "$", { desc = "End of line" })
map({ "n", "v" }, "H", "^", { desc = "Start of line" })

map("n", "<M-,>", "<C-w>5>", { desc = "Shift left window size" })
map("n", "<M-.>", "<C-w>5<", { desc = "Shift right window size" })
map("n", "<M-->", "<C-w>2-", { desc = "Decrease window size" })
map("n", "<M-=>", "<C-w>2+", { desc = "Increase window size" })

map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move Selected Line Below" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move Selected Line Below" })

map("n", "J", "mzJ`z")

map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "<C-f>", "<C-d>zz")
map("n", "<C-b>", "<C-u>zz")

map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

map("x", "p", '"_dP', { desc = "Paste w/o Clipboard" })
map("x", "<leader>p", '"+p', { desc = "Paste and copy into Clipboard" })
-- map({ "n", "v", "x" }, "d", '"_d', { desc = "Delete w/o clipboard" })
map({ "n", "v" }, "<leader>d", '"_d', { desc = "Delete w/o clipboard" })

map("n", "<cmd>w", function()
  local mod = vim.bo.buftype
  if mod ~= "nofile" and mod ~= "help" then
    local filename = vim.fn.expand("%:t")
    -- HACK: aint the best way just to hide the notify, but its bothering with the autocmds i made
    local isModified = vim.bo.modified
    if isModified then
      vim.notify(filename, 0, {
        title = "File saved!",
        timeout = 3500,
      })
    end
    vim.cmd("w")
  end
end, { desc = "Save file" })

map("n", "<leader>rp", ":%s/")
map("n", "<leader>rP", ":%s/<c-r><c-w>/")
map("v", "<leader>rp", ":'<,'>s/")
map("v", "<leader>rP", ":'<,'>s/<c-r><c-w>")
