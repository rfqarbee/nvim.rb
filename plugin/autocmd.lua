local MiscGroup = vim.api.nvim_create_augroup("miscGroup", { clear = true })
local WhiteSpace = vim.api.nvim_create_augroup("httpGroup", { clear = true })
local YankGroup = vim.api.nvim_create_augroup("HiglightYank", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "TermEnter", "TermLeave" }, {
  desc = "cd to term cwd on enter",
  pattern = "term://*",
  callback = function()
    local cwd = vim.fn.resolve("/proc/" .. vim.b.terminal_job_pid .. "/cwd")
    if vim.fn.isdirectory(cwd) == 0 then
      return
    end
    vim.fn.chdir(cwd)
  end,
})

vim.api.nvim_create_autocmd({ "QuickFixCmdPost" }, {
  desc = "open qf after populate",
  group = vim.api.nvim_create_augroup("qfpost", { clear = true }),
  command = "bot copen",
})

-- vim.api.nvim_create_autocmd({ "CursorHold" }, {
--   callback = function()
--     vim.diagnostic.open_float(nil, { focusable = false, source = "if_many", border = "rounded" })
--   end,
-- })

vim.api.nvim_create_autocmd("BufWritePre", {
  desc = "Delete trailing whitespace",
  pattern = "*",
  group = WhiteSpace,
  command = [[%s/\s\+$//e]],
})

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yank",
  group = YankGroup,
  callback = function()
    vim.hl.on_yank({ timeout = 100 })
  end,
})

vim.api.nvim_create_autocmd("VimResized", {
  desc = "Resize",
  pattern = "*",
  group = vim.api.nvim_create_augroup("ResizeWin", { clear = true }),
  command = "horizontal wincmd = | vertical wincmd =",
})

vim.api.nvim_create_user_command("ToggleDiagnostics", function()
  if vim.diagnostic.is_enabled() then
    vim.diagnostic.enable(not vim.diagnostic.is_enabled())
  else
    vim.diagnostic.enable(not vim.diagnostic.is_enabled())
  end
end, {})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "help",
  group = MiscGroup,
  callback = function()
    local ft = vim.bo.filetype
    vim.keymap.set({ "n", "x" }, "q", "<cmd>:quit<cr>", { desc = "Quit " .. ft, buffer = true, noremap = true })
    vim.keymap.set("n", "-", "<nop>", { buffer = true, noremap = true })

    if ft == "help" then
      vim.cmd("wincmd L")
      vim.cmd("vert resize 90")
    end
  end,
})
