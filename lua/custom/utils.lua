local M = {}

M.map = function(mode, lhs, rhs, opts)
  return vim.keymap.set(mode, lhs, rhs, opts)
end

M.qfix = function()
  local items = vim.fn.getqflist({ size = 0 }).size
  if items ~= 0 then
    return "  " .. items .. " "
  else
    return " "
  end
end

return M
