local M = {}

M.map = function(mode, lhs, rhs, opts)
  return vim.keymap.set(mode, lhs, rhs, opts)
end

local function count_items(qf_list)
  if #qf_list > 0 then
    local valid = 0
    for _, item in ipairs(qf_list) do
      if item.valid == 1 then
        valid = valid + 1
      end
    end
    if valid > 0 then
      return tostring(valid)
    end
  end
end

M.qfix = function()
  local qf_values = vim.fn.getqflist()
  local items = count_items(qf_values)
  if items then
    return "  " .. items .. " "
  else
    return " "
  end
end

M.replace_word = function(word, type)
  local current_word = vim.fn.expand(word)
  local prompt = "Replace: "
  if type then
    prompt = "Replace (v): "
  end
  vim.ui.input({ prompt = prompt .. current_word .. " -> " }, function(input)
    if input then
      if type then
        local wordReplaced = ":'<,'>s/" .. current_word .. "/" .. input .. "/g"
        vim.cmd(wordReplaced)
        vim.cmd(":normal ``<cr>")
      else
        local wordReplaced = ":%s/" .. current_word .. "/" .. input .. "/g"
        vim.cmd(wordReplaced)
        vim.cmd(":normal ``<cr>")
      end
    end
  end)
end

return M
