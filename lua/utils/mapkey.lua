local function map(mode, lhs, rhs, opts)
  return vim.keymap.set(mode, lhs, rhs, opts)
end

return map
