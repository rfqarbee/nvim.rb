local map = vim.keymap.set
local helper = require("helper.config_lualine")

-- unbind
map({ "n", "v" }, "Q", "<nop>")
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear highlight on search when Esc in normal mode" })

-- NOTE: remove this after complete my own colorscheme
map("n", "<leader>i", ":Inspect<cr>")

map("n", "<leader>qq", function()
  local qf_win = vim.fn.getqflist({ winid = 0 }).winid
  if qf_win ~= 0 then
    vim.cmd("cclose")
  else
    vim.cmd("bot copen")
  end
end, { desc = "Copen" })

map("n", "<leader>ql", function()
  local loc_win = vim.fn.getloclist(0, { winid = 0 }).winid
  if loc_win ~= 0 then
    vim.cmd("lclose")
  else
    vim.cmd("bot lopen")
  end
end, { desc = "Copen" })
-- more binds
map("n", "<C-q>", "<cmd>qa<CR>", { desc = "Quit Neovim" })
map("n", "<M-q>", "<cmd>q<CR>", { desc = "Quit Buffer/window/tabs/anything" })
map("i", "jk", "<Esc>", { desc = "Insert to normal mode" })

-- navigating quickfix
map("n", "<m-j>", "<cmd>cnext<cr>zz", { desc = "Next quickfix item" })
map("n", "<m-k>", "<cmd>cprev<cr>zz", { desc = "Prev quickfix item" })

-- navigating buffers
map("n", "[b", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "]b", "<cmd>bprev<cr>", { desc = "Prev Buffer" })

-- tabs
map("n", "[<tab>", "gt", { desc = "Next tab" })
map("n", "]<tab>", "gT", { desc = "Previous tab" })
map("n", "<leader>t.", "<cmd>+tabmove<cr>", { desc = "Move tab to right" })
map("n", "<leader>t,", "<cmd>-tabmove<cr>", { desc = "Move tab to left" })
map("n", "<leader>tn", "<cmd>tabnew<cr>", { desc = "Create new tab" })

map({ "n", "v" }, "L", "$", { desc = "End of line" })
map({ "n", "v" }, "H", "^", { desc = "Start of line" })

-- resize window; terminal doesnt register C-, (showkey -a)
map("n", "<M-,>", "<C-w>5>", { desc = "Shift left window size" })
map("n", "<M-.>", "<C-w>5<", { desc = "Shift right window size" })
map("n", "<M-->", "<C-w>2-", { desc = "Decrease window size" })
map("n", "<M-=>", "<C-w>2+", { desc = "Increase window size" })

--visual block to move around
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move Selected Line Below" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move Selected Line Below" })

--append line below to above, but cursor stays in place
map("n", "J", "mzJ`z")

--cursor in middle
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "<C-f>", "<C-d>zz")
map("n", "<C-b>", "<C-u>zz")

-- cursor in middle
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

map("x", "p", '"_dP', { desc = "Paste w/o Clipboard" })
map("x", "<leader>p", '"+p', { desc = "Paste and copy into Clipboard" })
-- map({"n","v"}, "d", '"_d', { desc = "Delete w/o clipboard" })
-- map({ "n", "v" }, "<leader>d", '"_d', { desc = "Delete w/o clipboard (v)" })

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

map("n", "<leader>rp", ":%s/<c-r><c-w>/")
map("n", "<leader>rP", ":%s/<c-r><c-a>/")
map("v", "<leader>rp", ":'<,'>s/<c-r><c-w>/")
map("v", "<leader>rP", ":'<,'>s/<c-r><c-a>/")

-- TODO:
-- doesnt increment search/hl; do this free time yeh?
-- map("v", "<leader>rp", function()
--   helper.replace_word("<cword>", "visual")
-- end, { desc = "Replace current word in visual mode" })
--
-- map("n", "<leader>rp", function()
--   helper.replace_word("<cword>")
-- end, { desc = "Replace current word" })
--
-- map("v", "<leader>rP", function()
--   helper.replace_word("<cWORD>", "visual")
-- end, { desc = "Replace current word in visual mode" })
--
-- map("n", "<leader>rP", function()
--   helper.replace_word("<cWORD>")
-- end, { desc = "Replace current word" })

-- map("n", "/", function()
--   vim.ui.input({ prompt = "Search word", completion = "arglist" }, function(input)
--     if input then
--       local status, error = pcall(vim.cmd, "/" .. input)
--       local function split(err)
--         local t = ""
--         for str in string.gmatch(err, "Vim:%s*(.*)") do
--           t = str
--         end
--         return t
--       end
--       if status ~= true then
--         print(split(error))
--       end
--     end
--   end)
-- end, { desc = "test" })

-- map("n", ":", function()
--   vim.ui.input({ prompt = "Command Mode", completion = "command" }, function(input)
--     if input then
--       local status, error = pcall(vim.cmd, ":" .. input)
--       local function split(err)
--         local t = ""
--         for str in string.gmatch(err, "Vim:%s*(.*)") do
--           t = str
--         end
--         return t
--       end
--       if status ~= true then
--         print(split(error))
--       end
--     end
--   end)
-- end, { desc = "test" })
