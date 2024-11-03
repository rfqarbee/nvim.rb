local function tab_name()
  local tabbufr = ""
  if vim.fn.tabpagenr() ~= nil then
    for i = 1, vim.fn.tabpagenr("$") do
      local winnr = vim.fn.tabpagewinnr(i)
      local bufnr = vim.fn.tabpagebuflist(i)[winnr]
      local ft = vim.bo.filetype
      local bufname = vim.fn.bufname(bufnr)
      local tabname = bufname ~= "" and vim.fn.fnamemodify(bufname, ":t") or "[No Name]"

      if i == vim.fn.tabpagenr() then
        if ft == "oil" or ft == "fzf" then
          tabbufr = tabbufr .. "%#TabLineSel# " .. i .. ": " .. ft .. " "
        else
          tabbufr = tabbufr .. "%#TabLineSel# " .. i .. ": " .. tabname .. " "
        end
      else
        tabbufr = tabbufr .. "%#TabLine# " .. i .. ": " .. tabname .. " "
      end
    end
  else
    return ""
  end
  return tabbufr
end

Tabline = {}

Tabline.line = function()
  return table.concat({ tab_name() })
end
