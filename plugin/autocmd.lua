-- due to nvim load plugin/ first
require("custom.statusline")
require("custom.tabline")

local autocmd = vim.api.nvim_create_autocmd
local usercmd = vim.api.nvim_create_user_command
local MiscGroup = vim.api.nvim_create_augroup("miscGroup", { clear = true })
local HttpGroup = vim.api.nvim_create_augroup("replaceGroup", { clear = true })
local gitGroup = vim.api.nvim_create_augroup("mygit", { clear = true })
local WhiteSpace = vim.api.nvim_create_augroup("httpGroup", { clear = true })
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

-- json file mainly http files response
autocmd("FileType", {
  group = HttpGroup,
  pattern = { "json" },
  callback = function()
    vim.api.nvim_set_option_value("formatprg", "jq", { scope = "local" })
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
    elseif vim.bo.filetype == "" then
      local filename = vim.fn.expand("%:t")
      if filename ~= "" then
        vim.opt_local.statusline = "%!v:lua.Statusline.active()"
      else
        vim.opt_local.statusline = "%!v:lua.Statusline.emptyBuf()"
      end
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

autocmd("User", {
  group = gitGroup,
  pattern = "FugitiveEditor",
  callback = function()
    vim.keymap.set("n", "q", "<cmd>q<cr>", { buffer = 0, noremap = true })
    vim.keymap.set("n", "<c-c>", "<cmd>wq<cr>", { buffer = 0, noremap = true })
    vim.keymap.set("n", "<c-c><c-k>", "<cmd>q!<cr>", { buffer = 0, noremap = true })
  end,
})

autocmd("FileType", {
  pattern = "help,fugitive,DiffviewFiles,git,fugitiveblame",
  group = MiscGroup,
  callback = function()
    local map = function(cmd, ft)
      vim.keymap.set({ "n", "x" }, "q", cmd, { desc = "Quit " .. ft, buffer = true, noremap = true })
    end
    local ft = vim.bo.filetype

    if ft == "DiffviewFiles" then
      map("<cmd>DiffviewClose<cr>", ft)
    else
      map("<cmd>q<cr>", ft)
    end

    if ft == "help" then
      vim.cmd("wincmd L")
      vim.cmd("vert resize 90")
    end
  end,
})

autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    local params = vim.lsp.util.make_range_params()
    params.context = { only = { "source.organizeImports" } }
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
    for cid, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
          vim.lsp.util.apply_workspace_edit(r.edit, enc)
        end
      end
    end
    vim.lsp.buf.format({ async = false })
  end,
})
