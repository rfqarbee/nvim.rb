local M = {}

local function get_dir()
  local current_path = vim.fn.expand("%:h")
  local parts = vim.split(current_path, "/")
  local shorten = table.concat(vim.list_slice(parts, #parts - 2), "/")
  return shorten
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

local function loclist()
  local loc_values = vim.fn.getloclist(vim.api.nvim_get_current_win())
  local items = count_items(loc_values)
  if items then
    return items
  else
    return nil
  end
end

local function qfix()
  local qf_values = vim.fn.getqflist()
  local items = count_items(qf_values)
  if items then
    return items
  else
    return nil
  end
end

local function replace_word(word, type)
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

M.replace_word = replace_word
M.qfix_item = qfix
M.loclist_item = loclist
M.get_dir = get_dir

return M
