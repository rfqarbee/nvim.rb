-- due to nvim load plugin/ first
require("custom.statusline")
require("custom.tabline")
local autocmd = vim.api.nvim_create_autocmd
local usercmd = vim.api.nvim_create_user_command
local WhiteSpace = vim.api.nvim_create_augroup("replaceGroup", { clear = true })
local YankGroup = vim.api.nvim_create_augroup("HiglightYank", { clear = true })
local SaveAll = vim.api.nvim_create_augroup("SaveAll", { clear = true })
local resizeWin = vim.api.nvim_create_augroup("resizeWin", { clear = true })
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
    vim.cmd([[bot copen]])
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

usercmd("ToggleDiagnostics", function()
  if vim.diagnostic.is_enabled() then
    vim.diagnostic.enable(not vim.diagnostic.is_enabled())
  else
    vim.diagnostic.enable(not vim.diagnostic.is_enabled())
  end
end, {})

-- TODO: rewrite this ass
-- autocmd("BufWritePost", {
--   desc = "Save modified files",
--   group = SaveAll,
--   pattern = "*",
--   callback = function()
--     local buflist = {}
--     local bufnum = {}
--     local buffer = vim.api.nvim_cmd({ cmd = "buffers" }, { output = true })
--     local function getstr(fullpath)
--       local segments = {}
--       for segment in string.gmatch(fullpath, "[^/]+") do
--         table.insert(segments, segment)
--       end
--
--       if #segments >= 2 then
--         return segments[#segments - 1] .. "/" .. segments[#segments]
--       elseif #segments == 1 then
--         return segments[1]
--       else
--         return nil
--       end
--     end
--     -- get all line
--     for line in buffer:gmatch("[^\r\n]+") do
--       table.insert(buflist, line)
--     end
--     -- only store buffer number
--     for _, line in ipairs(buflist) do
--       local getNum = line:match("^%s*(%d+)")
--       if getNum then
--         table.insert(bufnum, getNum)
--       end
--     end
--     -- save for buffers that has changes and notify
--     for _, bufnr in ipairs(bufnum) do
--       if vim.api.nvim_get_option_value("modified", { buf = tonumber(bufnr) }) then
--         local savedFiles = vim.api.nvim_buf_get_name(tonumber(bufnr))
--         vim.notify(getstr(savedFiles), vim.log.levels.INFO, {
--           title = "File saved!",
--           timeout = 3500,
--         })
--         vim.api.nvim_buf_call(tonumber(bufnr), function()
--           vim.cmd("silent write")
--         end)
--       end
--     end
--   end,
-- })
