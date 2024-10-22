local autocmd = vim.api.nvim_create_autocmd
local usercmd = vim.api.nvim_create_user_command
local WhiteSpace = vim.api.nvim_create_augroup("replaceGroup", { clear = true })
local YankGroup = vim.api.nvim_create_augroup("HiglightYank", { clear = true })
local SaveAll = vim.api.nvim_create_augroup("SaveAll", { clear = true })
local resizeWin = vim.api.nvim_create_augroup("resizeWin", { clear = true })
local Quickfix = vim.api.nvim_create_augroup("Quickfix", { clear = true })


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
  desc = "Readjust windows if vim resize",
  group = resizeWin,
  pattern = "*",
  callback = function()
    local ft = vim.bo.filetype
    vim.cmd("wincmd =")
    if ft == "fugitive" then
      vim.cmd("resize 32")("fugitive?")
    end
  end,
})

usercmd("ToggleDiagnostics", function()
  if vim.g.diagnostics_enabled == nil then
    vim.g.diagnostics_enabled = false
    vim.diagnostic.enable(not vim.diagnostic.is_enabled())
  elseif vim.g.diagnostics_enabled then
    vim.g.diagnostics_enabled = false
    vim.diagnostic.enable(not vim.diagnostic.is_enabled())
  else
    vim.g.diagnostics_enabled = true
    vim.diagnostic.enable(not vim.diagnostic.is_enabled())
  end
end, {})

-- TODO: rewrite this ass 
autocmd("BufWritePost", {
  desc = "Save modified files",
  group = SaveAll,
  pattern = "*",
  callback = function()
    local buflist = {}
    local bufnum = {}
    local buffer = vim.api.nvim_cmd({ cmd = "buffers" }, { output = true })
    local function getstr(fullpath)
      local segments = {}
      for segment in string.gmatch(fullpath, "[^/]+") do
        table.insert(segments, segment)
      end

      if #segments >= 2 then
        return segments[#segments - 1] .. "/" .. segments[#segments]
      elseif #segments == 1 then
        return segments[1]
      else
        return nil
      end
    end
    -- get all line
    for line in buffer:gmatch("[^\r\n]+") do
      table.insert(buflist, line)
    end
    -- only store buffer number
    for _, line in ipairs(buflist) do
      local getNum = line:match("^%s*(%d+)")
      if getNum then
        table.insert(bufnum, getNum)
      end
    end
    -- save for buffers that has changes and notify
    for _, bufnr in ipairs(bufnum) do
      if vim.api.nvim_get_option_value("modified", { buf = tonumber(bufnr) }) then
        local savedFiles = vim.api.nvim_buf_get_name(tonumber(bufnr))
        vim.notify(getstr(savedFiles), vim.log.levels.INFO, {
          title = "File saved!",
          timeout = 3500,
        })
        vim.api.nvim_buf_call(tonumber(bufnr), function()
          vim.cmd("silent write")
        end)
      end
    end
  end,
})

autocmd("QuickFixCmdPost", {
  group = Quickfix,
  callback = function()
    vim.cmd([[bot copen]])
  end,
})
