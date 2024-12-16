-- stole this from reddit
local qf_stats = require("custom.utils")
local modes = {
  ["n"] = "NORMAL",
  ["no"] = "NORMAL",
  ["v"] = "VISUAL",
  ["V"] = "VISUAL lINE",
  ["\22"] = "VISUAL BLOCK",
  ["s"] = "SELECT",
  ["S"] = "SELECT LINE",
  [""] = "SELECT BLOCK",
  ["i"] = "INSERT",
  ["ic"] = "INSERT",
  ["R"] = "REPLACE",
  ["Rv"] = "VISUAL REPLACE",
  ["c"] = "COMMAND",
  ["cv"] = "VIM EX",
  ["ce"] = "EX",
  ["r"] = "PROMPT",
  ["rm"] = "MOAR",
  ["r?"] = "CONFIRM",
  ["!"] = "SHELL",
  ["t"] = "TERMINAL",
}

local function mode()
  local current_mode = vim.api.nvim_get_mode().mode
  return string.format(" %s ", modes[current_mode])
end

local function update_mode_colors()
  local current_mode = vim.api.nvim_get_mode().mode
  local mode_color = "%#StatusLineCustom#"
  if current_mode == "n" then
    mode_color = "%#StatusLineCustom#"
  elseif current_mode == "i" or current_mode == "ic" then
    mode_color = "%#StatusLineInsert#"
  elseif current_mode == "v" or current_mode == "V" or current_mode == "\22" then
    mode_color = "%#StatusLineVisual#"
  elseif current_mode == "R" then
    mode_color = "%#StatusLineReplace#"
  elseif current_mode == "c" then
    mode_color = "%#StatusLineCmd#"
  else
    mode_color = "%#StatusLineReverse#"
  end
  return mode_color
end

local function file()
  local gitfile = ""
  local fname = ""
  local ft = vim.bo.filetype
  local fpath = vim.fn.fnamemodify(vim.fn.expand("%"), ":~:.:p")
  local isgit = vim.api.nvim_call_function("FugitiveIsGitDir", {})

  if fpath == "" or fpath == "." then
    return " "
  end

  if isgit == 1 then
    gitfile = vim.fn.fnamemodify(vim.api.nvim_call_function("FugitivePath", {}), ":~:.:p")
  end

  if ft == "oil" then
    fname = vim.fn.fnamemodify(vim.fn.getcwd(), ":~")
  else
    if gitfile == "" then
      fname = fpath
    else
      fname = gitfile
    end
  end

  return string.format(" %%<%s", fname)
end

local function filetype()
  return string.format(" %s | ", vim.bo.filetype)
end

local function lineinfo()
  return "| %l:%c | "
end

local function custominfo()
  local grapple = require("grapple")
  local status = grapple.statusline()
  local statusline = " <" .. status .. "> "

  if string.len(status) > 5 then
    return statusline
  else
    return ""
  end
end

local function fsize()
  local size = vim.fn.wordcount().bytes
  local kb = size / 1024
  local mb = kb / 1024
  local gb = mb / 1024

  local function remain(val)
    return math.floor(val % 1024)
  end

  if remain(kb) > 0 then
    return "" .. string.format("%.2f", kb) .. "K "
  elseif remain(mb) > 0 then
    return "" .. string.format("%.2f", mb) .. "M "
  elseif remain(gb) > 0 then
    return "" .. string.format("%.2f", gb) .. "G "
  else
    return "" .. size .. "B "
  end
end

local function vcs()
  local head = vim.api.nvim_call_function("FugitiveHead", {})
  local detach = string.gsub(vim.api.nvim_call_function("FugitiveStatusline", {}), "%[.-%((.-)%)%]", "%1")
  local isgit = vim.api.nvim_call_function("FugitiveIsGitDir", {})

  if not isgit then
    return ""
  else
    if head == "" and detach == "" then
      return ""
    elseif head ~= "" then
      return "  " .. head .. " "
    else
      return "  " .. detach .. " "
    end
  end
end

Statusline = {}

Statusline.active = function()
  return table.concat({
    "%#gitbranch#",
    vcs(),
    "%#gitbranch#",
    "%#StatusLineCustom#",
    update_mode_colors(),
    mode(),
    "%#StatusLineCustom#",
    "%#StatusLineQF#",
    qf_stats.qfix(),
    "%#StatusLineQF#",
    "%#Normal#",
    custominfo(),
    "%#Normal#",
    "%#StatusLineNormal#",
    file(),
    "%#StatusLineNormal#",
    "%=%#StatusLineExtra#",
    update_mode_colors(),
    filetype(),
    fsize(),
    lineinfo(),
  })
end

function Statusline.inactive()
  return " %F"
end

function Statusline.oil()
  local dirPath = vim.fn.fnamemodify(vim.fn.expand("%"), ":s?oil://??:~:.")
  return "%#StatusLine#   " .. dirPath
end

function Statusline.fzf()
  return "%#StatusLine#   Fzf"
end
