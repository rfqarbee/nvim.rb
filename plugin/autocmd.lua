-- due to nvim load plugin/ first
require("custom.statusline")
require("custom.tabline")

local autocmd = vim.api.nvim_create_autocmd
local usercmd = vim.api.nvim_create_user_command
local WhiteSpace = vim.api.nvim_create_augroup("replaceGroup", { clear = true })
local YankGroup = vim.api.nvim_create_augroup("HiglightYank", { clear = true })
local Quickfix = vim.api.nvim_create_augroup("Quickfix", { clear = true })
local Statusline = vim.api.nvim_create_augroup("Statusline", { clear = true })
local TablineGroup = vim.api.nvim_create_augroup("Tabline", { clear = true })

local status_events = {
  "BufEnter",
  "WinEnter",
  "FileType",
  "VimResized",
  "BufWritePost",
  "FileChangedShellPost",
  "SessionLoadPost",
  "CursorMoved",
  "CursorMovedI",
  "ModeChanged",
}
local tab_events = {
  "BufEnter",
  "WinEnter",
  "VimResized",
  "SessionLoadPost",
  "TabEnter",
  "TabLeave",
  "TabNew",
}

autocmd("QuickFixCmdPost", {
  group = Quickfix,
  callback = function()
    local qflist = vim.fn.getqflist()
    if qflist then
      vim.cmd([[bot copen]])
    end
  end,
})

autocmd(tab_events, {
  desc = "Tab line",
  group = TablineGroup,
  callback = function()
    vim.opt_local.tabline = "%!v:lua.Tabline.line()"
  end,
})

autocmd(status_events, {
  desc = "Status line",
  group = Statusline,
  callback = function()
    if vim.bo.filetype == "oil" then
      vim.opt_local.statusline = "%!v:lua.Statusline.oil()"
    elseif vim.bo.filetype == "fzf" then
      vim.opt_local.statusline = "%!v:lua.Statusline.fzf()"
    else
      vim.opt_local.statusline = "%!v:lua.Statusline.active()"
    end
  end,
})

autocmd("BufWritePre", {
  desc = "Delete trailing whitespace",
  pattern = "*",
  group = WhiteSpace,
  command = [[%s/\s\+$//e]],
})

autocmd("TextYankPost", {
  desc = "Highlight when yank",
  group = YankGroup,
  callback = function()
    vim.highlight.on_yank({
      higroup = "Yank",
      timeout = 50,
    })
  end,
})

autocmd("VimResized", {
  desc = "Resize",
  pattern = "*",
  group = vim.api.nvim_create_augroup("ResizeWin", { clear = true }),
  command = "horizontal wincmd = | vertical wincmd =",
})

usercmd("ToggleDiagnostics", function()
  if vim.diagnostic.is_enabled() then
    vim.diagnostic.enable(not vim.diagnostic.is_enabled())
  else
    vim.diagnostic.enable(not vim.diagnostic.is_enabled())
  end
end, {})
